# frozen_string_literal: true

class Public::BoardCommentsController < ApplicationController

  before_action :authenticate_user!

  def index; end

  def create
    board = Board.find(params[:board_id])
    board_comment = current_user.board_comments.new(board_comment_params)
    board_comment.board_id = board.id
    #binding.pry
    if board_comment.save
      redirect_to public_board_path(board)
      flash[:notice] = "投稿しました"
    else
      redirect_back(fallback_location: root_path)
      flash[:alert] = "投稿できませんでした"
    end

  end

  def destroy
    board_comment = BoardComment.find(params[:id])
    board = Board.find_by(params[:board_id])
    if board_comment.destroy
      redirect_to public_board_path(board.id)
       binding.pry
      flash[:alert] = "投稿を削除しました"
    else
      redirect_back(fallback_location: root_path)
      flash[:alert] = "削除ができませんでした"
    end
  end

  def edit; end

  private

  def board_comment_params
  	params.require(:board_comment).permit(:comment)
  end

end
