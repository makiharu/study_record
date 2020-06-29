class BoardTag < ApplicationRecord
  belongs_to :tag
  belongs_to :board
end
