class Board < ApplicationRecord
  belongs_to :user
  belongs_to :board_tag

  attachment :image

  validates :title, presence: true, length: { minimum: 2, maximum: 200 }
  validates :subject, presence: true, length: { minimum: 2 }
  validates :body, presence: true, length: { maximum: 2000 }
  validates :board, inclusion: {in: [true, false]}


end

