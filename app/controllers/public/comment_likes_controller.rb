class Public::CommentLikesController < ApplicationController
	def create
		board = Board.find_by(params[:board_id])
		board_comment = BoardComment.find(params[:board_comment_id])
		comment_like = current_user.comment_likes.new(board_comment_id: board_comment.id)
		comment_like.save
		redirect_to public_boards_path
	end

	def destroy
		board_comment = BoardComment.find(params[:board_comment_id])
		comment_like = current_user.comment_likes.find_by(board_comment_id: board_comment.id)
		comment_like.save
		redirect_to public_boards_path

	end
end


       # def create
       #      post_image = PostImage.find(params[:post_image_id])
       #      favorite = current_user.favorites.new(post_image_id: post_image.id)
       #      favorite.save
       #      redirect_to post_image_path(post_image)
       #  end
       #  def destroy
       #      post_image = PostImage.find(params[:post_image_id])
       #      favorite = current_user.favorites.find_by(post_image_id: post_image.id)
       #      favorite.destroy
       #      redirect_to post_image_path(post_image)
       #  end