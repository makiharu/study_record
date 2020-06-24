# frozen_string_literal: true

class Public::BoardCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
  	board = Board.find(params[:id])
  	board_comment = current_user.board_comments.new
    binding.pry

  end

  def destroy; end

  def edit; end



  def edit; end
end
