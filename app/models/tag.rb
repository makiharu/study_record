class Tag < ApplicationRecord
  has_many :board_tag, dependent: :destroy

  validates :name, presence: true
  validates :is_void, inclusion: { in: [true, false] }
end
