class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :post_tags
  has_many :tags, through: :post_tags

  accepts_nested_attributes_for :post_tags, :tags

  validates :description, presence: true
  validates :snippit, presence: true

  def all_tags=(names)
    self.tags = names.split(",").map do |name|
        Tag.where(name: name.strip).first_or_create!
    end
  end

  def all_tags
    self.tags.map(&:name).join(", ")
  end

  filterrific(
    default_filter_params: { sorted_by: 'name_asc' },
    available_filters: [
      :sorted_by,
      :search_query,
      :tag_search_query
    ]
  )

  scope :search_query, lambda { |query|

    return nil if query.blank?

    terms = query.downcase.split(/\s+/)

    terms = terms.map { |e|
      (e.gsub('*', '%') + '%').gsub(/%+/, '%')
    }

    num_or_conds = 1
    where(
      terms.map { |term|
        "(LOWER(posts.description) LIKE ?)"
      }.join(' AND '),
      *terms.map { |e| [e] * num_or_conds }.flatten
    )
  }

  scope :tag_search_query, lambda { |query|

    return nil if query.blank?

    terms = query.downcase.split(/\s+/)
    puts terms

    num_or_conds = 1
    where(
      terms.map { |term|
        tag = Tag.find_by_name(term)
        if tag != nil
          "("+Tag.find_by_name(term).posts.map { |post|
            "posts.id = "+post.id.to_s
          }.join(' OR ')+")"
        end
      }.join(' AND '),
      *terms.map { |e| [e] * num_or_conds }.flatten
    )
  }

  scope :sorted_by, lambda { |sort_option|
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
      when /^name_/
        order("LOWER(posts.description) #{ direction }")
      else
        raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  def self.options_for_sorted_by
    [
      ['Name (a-z)', 'name_asc'],
      ['Name (z-a)', 'name_desc']
    ]
  end

end
