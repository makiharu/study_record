class Todolist < ApplicationRecord
  belongs_to :user
  has_many :label_lists, dependent: :delete_all
  has_many :labels, through: :label_lists

  accepts_nested_attributes_for :label_lists

  validates :content, presence: true, length: { maximum: 50 }

  enum time_category: { today: 0, week: 1, month: 2 }

  scope :only_done, -> { where(done: true) }
  scope :not_done, -> { where(done: false) }

end
