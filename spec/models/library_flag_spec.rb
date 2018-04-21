require 'rails_helper'

RSpec.describe LibraryFlag, type: :model do
  # associations
  it { should belong_to(:library)}
  # validations
  
end
