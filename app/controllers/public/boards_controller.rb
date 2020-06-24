# frozen_string_literal: true

class Public::BoardsController < ApplicationController

  before_action :authenticate_user!

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

  def edit; end

  private

  def board_params
    params.require(:board).permit(:title, :subject, :body)
  end
end
