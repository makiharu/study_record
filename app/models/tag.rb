class Tag < ApplicationRecord
	has_many :board_tag

	validates :name, presence: true
	validates :is_void, inclusion: {in: [true, false]}

end


