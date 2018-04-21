FactoryBot.define do
  factory :library do
    name { Faker::Pokemon.name }
    lat { 37.791821 }
    lon { -122.394679 }
  end
end