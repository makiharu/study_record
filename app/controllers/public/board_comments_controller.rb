class Public::BoardCommentsController < ApplicationController
  before_action :authenticate_user!
  #before_action :set_board_comment, only: %i[update destroy]
  before_action :correct_comment, only: %i[edit update destroy]

  def index; end

  def create
    board = Board.find(params[:board_id])
    board_comment = current_user.board_comments.new(board_comment_params)
    board_comment.board_id = board.id
    if board_comment.save
      redirect_to board_path(board)
      flash[:notice] = "投稿しました"
    else
      redirect_back(fallback_location: root_path)
      flash[:alert] = "投稿できませんでした"
    end
  end

  def destroy
    board = Board.find_by(params[:board_id])
    if board_comment.destroy
      redirect_back(fallback_location: root_path)
      flash[:warning] = "投稿を削除しました"
    else
      redirect_back(fallback_location: root_path)
      flash[:alert] = "削除ができませんでした"
    end
  end

  def edit
    # viewで渡す変数のため、@が必要。correct_commentでは不可。
    @board_comment = BoardComment.find(params[:board_id])
    @board_comment.user_id = current_user.id
  end

  def update
    if board_comment.update(board_comment_params)
      redirect_to board_path(board_comment.board.id)
      flash[:success] = 'コメントの内容を保存しました'
    else
      redirect_to board_path(board_comment.board.id)
      flash[:alert] = '変更内容を保存できませんでした'
    end
  end

  private

  def board_comment_params
    params.require(:board_comment).permit(:comment)
  end

  def correct_comment
    board_comment = BoardComment.find(params[:board_id])
    if board_comment.user_id != current_user.id
      redirect_to board_path(board_comment.board.id)
    end
   end

end
