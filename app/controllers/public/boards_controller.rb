class Public::BoardsController < ApplicationController
  before_action :authenticate_user!, unless: :login_admin
  before_action :authenticate_admin!, if: :login_admin
  before_action :set_board, only: %i[show edit update]
  before_action :correct_board, only: %i[edit update]

  def new
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)
    @board.user_id = current_user.id
    if @board.save
      redirect_to board_path(@board)
      flash[:notice] = "投稿しました"
    else
      render :new
    end
  end

  def index
    @boards = Board.all.order(created_at: :desc).page(params[:page]).per(10)
    @board_ranking = Board.create_rankings

    @tags = Tag.all
    @board_tags = BoardTag.all
    @new_boards = Board.new_order
    @new_board_tags = BoardTag.new_tag_order
    if params[:tag_id]
      tag = Tag.find(params[:tag_id])
      @boards = tag.boards.page(params[:page]).per(10)
    end
  end

  def show
    @board = Board.find(params[:id])
    @new_comment = BoardComment.new
    @new_comment.board_id = @board.id
    #if current_user.present?
    @new_comment.user_id = current_user.id
    #end

    @board_comments = @board.board_comments
  end

  def edit; end

  def update
    @board.user_id = current_user.id
    if @board.update(board_params)
      redirect_to board_path(@board)
      flash[:notice] = "変更内容を保存しました"
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
  end

  def correct_board
    board = Board.find(params[:id])
    if board.user_id != current_user.id
      redirect_to boards_path
    end
  end

end
