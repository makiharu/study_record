# frozen_string_literal: true

class Board < ApplicationRecord
  belongs_to :user

  attachment :image
end
