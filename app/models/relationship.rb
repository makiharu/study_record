class Relationship < ApplicationRecord
  # class_name: ‘User’/Followクラスという存在しないクラスを参照することを防
  # User クラスであることを明示

  belongs_to :user
  belongs_to :follow, class_name: 'User'

  validates :user_id, presence: true
  validates :follow_id, presence: true
end
