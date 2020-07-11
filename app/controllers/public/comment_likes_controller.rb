class Public::CommentLikesController < ApplicationController
  def create
    @board_comment = BoardComment.find(params[:board_comment_id])
    comment_like = current_user.comment_likes.new(board_comment_id: @board_comment.id)
    comment_like.save
  end

  def destroy
    @board_comment = BoardComment.find(params[:board_comment_id])
    comment_like = current_user.comment_likes.find_by(board_comment_id: @board_comment.id)
    comment_like.destroy
  end
end
