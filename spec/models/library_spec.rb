require 'rails_helper'

RSpec.describe Library, type: :model do
  # associations
  it { should have_many(:library_flags).dependent(:destroy)}
  # validations
  it {should validate_presence_of(:lat)}
  it {should validate_presence_of(:lon)}
end
