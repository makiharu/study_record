class Board < ApplicationRecord
  belongs_to :user
  has_many :board_tag, dependent: :destroy
  has_many :board_comments, dependent: :destroy

  attachment :image

  validates :title, presence: true, length: { minimum: 2, maximum: 20 }
  validates :subject, presence: true, length: { maximum: 20 }
  validates :body, presence: true, length: { maximum: 2000 }
  validates :display, inclusion: {in: [true, false]}

 #  	#引数で渡されたユーザidがテーブル内に存在するかどうか判定
	# def comment_likes_by?(user)
	# 	comment_likes.where(user_id: current_user.id)
	# end

end

