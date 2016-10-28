#app/models/photo.rb
 
class Photo < ActiveRecord::Base
  dragonfly_accessor :image
 
  #title validation
  validates_presence_of :title
 
  #image validations
  validates_presence_of :image
  validates_size_of :image, maximum: 400.kilobytes,
                    message: "should not be more than 400KB", if: :image_changed?
 
  validates_property :format, of: :image, in: ['jpeg', 'png', 'gif'],
                      message: "the formats allowed are: .jpeg, .png, .gif", if: :image_changed?
end