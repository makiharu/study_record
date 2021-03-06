class BoardComment < ApplicationRecord
  belongs_to :user
  belongs_to :board
  has_many :comment_likes, dependent: :delete_all

  validates :comment, presence: true, length: { maximum: 1500 }

  # 引数で渡されたユーザidがテーブル内に存在するかどうか判定
  def comment_liked_by?(user)
    comment_likes.where(user_id: user.id).exists?
  end
end
