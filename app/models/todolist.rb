class Todolist < ApplicationRecord
  belongs_to :user
  has_many :label_lists, dependent: :delete_all
  has_many :labels, through: :label_lists

  accepts_nested_attributes_for :label_lists

  validates :content, presence: true, length: { maximum: 50 }

  enum time_category: { today: 0, week: 1, month: 2 }

  scope :only_done, -> { where(done: true) }


# todolists
# id | content |
# 10 | '食器洗う'
# 20 | '牛乳を買う'

# label_lists
# id | todolist_id | label_id
# 1 | 10 | 100
# 2 | 20 | 100
# 3 | 10 | 200

# labels
# id | name |
# 100 | '家事'
# 200 | '私用'


# "SELECT \"labels\".* FROM \"labels\"
# INNER JOIN \"label_lists\" ON \"labels\".\"id\" = \"label_lists\".\"label_id\" 
# INNER JOIN \"todolists\" ON \"label_lists\".\"todolist_id\" = \"todolists\".\"id\" 
# WHERE \"todolists\".\"user_id\" = 51"


#  "SELECT \"labels\".* FROM \"labels\"
#   INNER JOIN \"label_lists\" ON \"labels\".\"id\" = \"label_lists\".\"label_id\"
#   WHERE \"label_lists\".\"todolist_id\" = 10"

# label_lists.id | label_lists.todolist_id | label_lists.label_id | labels.id | labels.name 
# 1 | 10 | 100 | 100 | '家事'
# #2 | 20 | 100 | 100 | '家事'
# 3 | 10 | 200 | 200 | '私用'

# labels
# id | name |
# 100 | '家事'
# 200 | '私用'


# todolists.id | todolists.content | label_lists.id | label_lists.todolist_id | label_lists.label_id
# 10 | '食器洗う' | 1 | 10 | 100
# 10 | '食器洗う' | 3 | 10 | 200
# 20 | '牛乳を買う' | 2 | 20 | 100


end
