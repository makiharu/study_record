class Public::BoardLikesController < ApplicationController
  def create
    board = Board.find(params[:board_id])
    board_like = current_user.board_likes.new(board_id: board.id)
    if board_like.save
      redirect_to public_board_path(board)
    else
      redirct_back(fallback_location: root_path)
    end
  end

  def destroy
    board = Board.find(params[:board_id])
    board_like = current_user.board_likes.find_by(params[:board_id])
    board_like.destroy
    redirect_to public_board_path(board)
  end
end
