class Public::BoardLikesController < ApplicationController
  def create
    @board = Board.find(params[:board_id])
    board_like = current_user.board_likes.new(board_id: @board.id)
    board_like.save
  end

  def destroy
    @board = Board.find(params[:board_id])
    board_like = current_user.board_likes.find_by(params[:board_id])
    board_like.destroy
  end
end
