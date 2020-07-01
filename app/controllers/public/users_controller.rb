class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show edit update]

  def index
    @users = User.all
  end

  def show
    @chart = { '2019-06-01' => 60, '2019-06-02' => 65, '2019-06-03' => 64 }
    @data = { 'Ruby' => 30, 'HTML&CSS' => 80, 'JS' => 50 }
    # @data = {'ラベル名' => 達成したリストの数...}
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to public_user_path(@user)
      flash[:notice] = "success!"
    else
      render :edit
    end
  end

  def complete; end

  def follows
    @user = User.find(params[:id])
    @users = @user.followings
 end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile_image)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
