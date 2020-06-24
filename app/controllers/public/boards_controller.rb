# frozen_string_literal: true

class Public::BoardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_board, only: %i[show edit update]

  def new
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)
    @board.user_id = current_user.id
    if @board.save
      redirect_to public_boards_path
      flash[:notice] = "success"
    else
      render :new
    end
  end

  def index
    @boards = Board.page(params[:page]).per(10)
  end

  def show; end

  def edit
  end

  def update
    if @board.update(board_params)
      redirect_to public_board_path(@board)
      flash[:notice] = "successful"
    else
      render :edit
    end
  end

  private

  def board_params
    params.require(:board).permit(:title, :subject, :body)
  end

  def set_board
    @board = Board.find(params[:id])
  end
end
