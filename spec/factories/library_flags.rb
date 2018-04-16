FactoryBot.define do
  factory :library_flag do
    name { Faker::StarWars.character }
    done false
    todo_id nil
  end
end