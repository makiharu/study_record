class Todolist < ApplicationRecord
	belongs_to :user

	validates :content, presence: true, length: { maximum:40 }

	enum time_category: { today: 0, week: 1, month: 2}
end
