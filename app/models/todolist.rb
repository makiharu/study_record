class Todolist < ApplicationRecord
  belongs_to :user

  validates :content, presence: true, length: { maximum: 30 }

  #enum time_category: { today: 0, week: 1, month: 2 }
  enum time_category: { 本日: 0, 今週目標: 1, 今月目標: 2 }
end
