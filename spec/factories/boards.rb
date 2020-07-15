FactoryBot.define do
  factory :board do
  	title { Faker::Lorem.characters(number:10) }
  	body { Faker::Lorem.characters(number:20) }
  end
end
