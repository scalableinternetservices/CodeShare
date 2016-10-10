class Post < ApplicationRecord
  belongs_to :user
  has_many :comments

  validates :description, presence: true
  validates :snippit, presence: true
end
