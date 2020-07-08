class Manage::BoardsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_board, only: %i[show edit update]

  def new
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)
    @board.user_id = current_user.id
    if @board.save
      redirect_to public_board_path(@board)
      flash[:notice] = "success"
    else
      render :new
    end
  end

  def index
    @boards = Board.all.order(created_at: :desc).page(params[:page]).per(10)
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

  def edit
    @board.user_id = current_user.id
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
    params.require(:board).permit(:title, :body, tag_ids: [])
    # 複数のモデルが渡ってくるので、配列として、このような書き方
    # モデル名の単数形_ids 従属するモデルのid（主キー）の配列を返す
  end

  def set_board
    @board = Board.find(params[:id])
    # @name = action_name
  end
end

