class Board < ApplicationRecord
  belongs_to :user
  has_many :board_tag, dependent: :destroy
  has_many :board_comments, dependent: :destroy

  attachment :image

  validates :title, presence: true, length: { minimum: 2, maximum: 20 }
  validates :subject, presence: true, length: { maximum: 20 }
  validates :body, presence: true, length: { maximum: 2000 }
  validates :display, inclusion: {in: [true, false]}


end

