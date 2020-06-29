class Board < ApplicationRecord
  belongs_to :user
  has_many :board_tags, dependent: :delete_all
  has_many :tags, through: :board_tags
  # through :中間テーブルを通して、boardモデルを結びつけるための設定,

  has_many :board_comments, dependent: :delete_all
  has_many :board_likes, dependent: :delete_all
  attachment :image

  validates :title, presence: true, length: { maximum: 20 }
  validates :subject, presence: true, length: { maximum: 20 }
  validates :body, presence: true, length: { maximum: 1500 }
  validates :display, inclusion: { in: [true, false] }

  #  	#引数で渡されたユーザidがテーブル内に存在するかどうか判定
  def board_liked_by?(user)
    board_likes.where(user_id: user.id).exists?
  end
end
