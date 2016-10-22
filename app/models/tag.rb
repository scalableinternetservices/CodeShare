class Tag < ApplicationRecord
  has_many :post_tags
  has_many :posts, through: :post_tags

  before_save { name.downcase! }
end
