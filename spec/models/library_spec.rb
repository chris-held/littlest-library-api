require 'rails_helper'

RSpec.describe Library, type: :model do
  # validations
  it {should validate_presence_of(:lat)}
  it {should validate_presence_of(:lon)}
  it {should validate_presence_of(:address)}
  it {should validate_presence_of(:city)}
  it {should validate_presence_of(:state)}
  it {should validate_presence_of(:zip)}
end
