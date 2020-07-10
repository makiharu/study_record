class Tag < ApplicationRecord
  has_many :board_tags, dependent: :delete_all
  has_many :boards, through: :board_tags

  validates :name, presence: true, uniqueness: true
  validates :is_void, inclusion: { in: [true, false] }

  scope :valid, -> { where(is_void: false) }
  scope :invalid, -> { where(is_void: true) }

end
