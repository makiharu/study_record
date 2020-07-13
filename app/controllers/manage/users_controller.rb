class Manage::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user, only: %i[show edit update]

  def index
    @users = User.all.order(created_at: :desc).page(params[:page]).per(15)
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to manage_user_path(@user)
      flash[:notice] = '変更内容を保存しました'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :is_deleted)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
