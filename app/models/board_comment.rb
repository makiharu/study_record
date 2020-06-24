class BoardComment < ApplicationRecord
	belongs_to :user
	belongs_to :board

	validates :board_comment, presence: true, length: {maximum: 2000}

end
