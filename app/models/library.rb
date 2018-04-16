class Library < ApplicationRecord
  has_many :library_flags, dependent: :destroy
  validates_presence_of :lat, :lon
end
