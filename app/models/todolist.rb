class Todolist < ApplicationRecord
  belongs_to :user

  enum time_category: { today: 0, week: 1, month: 2 }
end
