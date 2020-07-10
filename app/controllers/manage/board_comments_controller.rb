class Manage::BoardCommentsController < ApplicationController

	def destroy
	  board_comment = BoardComment.find(params[:board_id])
	  #board = Board.find_by(params[:board_id])
	  if board_comment.destroy
	  	redirect_back(fallback_location: root_path)
	  	flash[:alert] = "投稿を削除しました"
	  else
	  	redirect_back(fallback_location: root_path)
        flash[:alert] = "削除ができませんでした"
	  end
	end
end

