class Public::CommentLikesController < ApplicationController
  def create
    @board_comment = BoardComment.find(params[:board_comment_id])
    comment_like = current_user.comment_likes.new(board_comment_id: @board_comment.id)
    comment_like.save
    #redirect_back(fallback_location: root_path)
    # binding.pry
  end

  def destroy
    # binding.pry
    # Client.find_by first_name: 'Lifo'
    # Client.find_by(first_name: 'Lifo')
    # Client.where(first_name: 'Lifo').take # []  => nil
    # Client.where(first_name: 'Lifo')[0] # []  => undifined method [
    # find_byはカラム指定しないとだめ
    @board_comment = BoardComment.find(params[:board_comment_id])
    comment_like = current_user.comment_likes.find_by(board_comment_id: @board_comment.id)
    comment_like.destroy
    #redirect_back(fallback_location: root_path)
  end
end
