# frozen_string_literal: true

class Board < ApplicationRecord
  belongs_to :user

  attachment :image

  validates :title, presence: true, length: {minimum: 2, maximum: 200}
  validates :subject, presence: true, length: {minimum: 2}
  validates :body, presence: true, length: {maximum: 2000}

end


