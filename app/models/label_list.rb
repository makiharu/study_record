class LabelList < ApplicationRecord
  belongs_to :label
  belongs_to :todolist
end
