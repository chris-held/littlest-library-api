class Library < ApplicationRecord
  has_many :library_flags, dependent: :destroy
  validates_presence_of :lat, :lon
  acts_as_mappable :lat_column_name => :lat, 
                   :lng_column_name => :lon
  mount_base64_uploader :image, ImageUploader

end
