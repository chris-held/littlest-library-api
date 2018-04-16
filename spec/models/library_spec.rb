require 'rails_helper'

RSpec.describe Library, type: :model do
  # validations
  it {should validate_presence_of(:lat)}
  it {should validate_presence_of(:lon)}
end
