class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show edit update]

  def index
    @users = User.all
  end

  def show
    @todolist = Todolist.new
    @todolists = Todolist.all
  end

  def edit
  end

  def update
  	if @user.update(user_params)
  		redirect_to public_user_path(@user)
  		flash[:notice] = "success!"
  	else
  		render :edit
  	end
  end



  def complete; end

  private

  def user_params
  	params.require(:user).permit(:name, :email, :profile_image)
  end

  def set_user
  	@user = User.find(params[:id])
  end
end
