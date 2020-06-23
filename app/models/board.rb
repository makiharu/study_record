class Board < ApplicationRecord
  belongs_to :user

  attachment :image
end
