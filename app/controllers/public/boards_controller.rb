# frozen_string_literal: true

class Public::BoardsController < ApplicationController
  def new
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)
    @board.user_id = current_user.id
    if @board.save
      redirect_to board_path
    else
      render :new
    end
  end

  def index
    @boards = Board.all
  end

  def show; end

  def edit; end

  private

  def board_params
    params.require(:board).permit(:title, :subject, :body)
  end
end
