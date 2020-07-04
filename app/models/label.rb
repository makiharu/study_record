class Label < ApplicationRecord
	has_many :label_lists, dependent: :destroy

	validates :name, presence: true
end
