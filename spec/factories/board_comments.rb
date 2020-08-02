FactoryBot.define do
	factory :board_comment do
		content { Faker::Lorem.characters(number:30) }
    end
end
