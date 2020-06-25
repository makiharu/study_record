class BoardComment < ApplicationRecord
	belongs_to :user
	belongs_to :board
  	has_many :board_comments, dependent: :destroy

	validates :comment, presence: true
end
