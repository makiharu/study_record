FactoryBot.define do
  factory :todolist do
    content { Faker::Lorem.characters(number:10) }
  end
end