class Library < ApplicationRecord
  validates_presence_of :lat, :lon
end
