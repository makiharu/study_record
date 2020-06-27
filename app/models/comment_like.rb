class CommentLike < ApplicationRecord
	belongs_to :user
	belongs_to :board_comment

# 　validates :user_id, {presence: true}
#   validates :board_comment_id, {presence: true}


end
