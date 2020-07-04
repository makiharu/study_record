class Label < ApplicationRecord
	has_many :label_lists, dependent: :delete_all
	has_many :todolists, through: :label_lists

	validates :name, presence: true
	validates :is_void, inclusion: { in: [true, false] }
end

