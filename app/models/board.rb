class Board < ApplicationRecord
  belongs_to :user
  has_many :board_tag, dependent: :destroy

  attachment :image

  validates :title, presence: true, length: { minimum: 2, maximum: 200 }
  validates :subject, presence: true, length: { minimum: 2 }
  validates :body, presence: true, length: { maximum: 2000 }
  validates :display, inclusion: {in: [true, false]}


end

