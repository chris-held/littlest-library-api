class Library < ApplicationRecord
  validates_presence_of :lat, :lon, :address, :city, :state, :zip
end
