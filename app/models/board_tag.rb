class BoardTag < ApplicationRecord
  belongs_to :tag
  belongs_to :board

  def self.new_tag_order
    BoardTag.all.order(created_at: :desc).limit(3)
  end
end
