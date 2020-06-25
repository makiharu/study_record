class BoardComment < ApplicationRecord
	belongs_to :user
	belongs_to :board
  	has_many :comment_likes, dependent: :destroy

	validates :comment, presence: true

	#引数で渡されたユーザidがテーブル内に存在するかどうか判定
	def comment_likes_by?(user)
		comment_likes.where(user_id: user.id).exists?
	end
end
