class Todolist < ApplicationRecord
  belongs_to :user

  validates :content, presence: true, length: { maximum: 30 }

  enum time_category: { today: 0, week: 1, month: 2 }
  # enum time_category: { 本日: 0, 今週目標: 1, 今月目標: 2 }

  enum label: { HTML: 0,
                JavaScript: 1,
                jQuery: 2,
                Ruby: 3,
                RubyonRails: 4,
                PHP: 5,
                Java: 6,
                Python: 7,
                CommandLine: 8,
                Git: 9,
                SQL: 10,
                Sass: 11,
                React: 12,
                # Node.js: 13,
                another: 14 }
end
