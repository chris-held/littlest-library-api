FactoryBot.define do
  factory :library do
    name { Faker::Pokemon.name }
    lat { Faker::Address.latitude }
    lon { Faker::Address.longitude }
  end
end