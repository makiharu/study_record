class Tag < ApplicationRecord
  has_many :board_tags, dependent: :delete_all
  has_many :boards, through: :board_tags
  # through :中間テーブルを通して、boardモデルを結びつけるための設定

  validates :name, presence: true, uniqueness: true
  validates :is_void, inclusion: { in: [true, false] }

  # enum is_void: { "有効" => false, "無効" => true }
end
