FactoryBot.define do
  factory :library do
    name { Faker::Pokemon.name }
    lat { 0 }
    lon { 0 }
  end
end