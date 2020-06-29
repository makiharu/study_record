class Manage::BoardsController < ApplicationController
  def index
    @boards = Board.all.order(created_at: :desc).page(params[:page]).per(10)
    # @boards = Board.all
  end

  def show; end
end
