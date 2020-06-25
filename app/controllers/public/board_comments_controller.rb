# frozen_string_literal: true

class Public::BoardCommentsController < ApplicationController
<<<<<<< HEAD

  before_action :authenticate_user!

  def index; end

=======
  before_action :authenticate_user!

  def create
    board = Board.find(params[:id])
    board_comment = current_user.board_comments.new
    binding.pry
  end

  def destroy; end

  def edit; end

>>>>>>> test
  def edit; end
end
