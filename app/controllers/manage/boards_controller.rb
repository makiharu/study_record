class Manage::BoardsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_board, only: %i[show destroy]

  def index
    @boards = Board.all.order(created_at: :desc).page(params[:page]).per(15)
    @search = Board.ransack(params[:q])
    @searchboards = @search.result
    #@page_boards = Board.all.order(created_at: :desc).page(params[:page]).per(10)
    @tags = Tag.all
    @board_tags = BoardTag.all
    if params[:tag_id]
      tag = Tag.find(params[:tag_id])
      @boards = tag.boards.page(params[:page]).per(10)
    end
  end

  def show
    @new_comment = BoardComment.new
    @new_comment.board_id = @board.id
    if current_user.present?
    @new_comment.user_id = current_user.id
    end
    @board_comments = @board.board_comments
  end

  def destroy
    if @board.destroy
      redirect_to manage_boards_path
      flash[:warning] = "投稿内容を削除しました"
    else
      render :show
    end
  end

  private

  def set_board
    @board = Board.find(params[:id])
  end

end

