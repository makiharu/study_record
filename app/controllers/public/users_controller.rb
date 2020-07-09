class Public::UsersController < ApplicationController
  before_action :authenticate_user!, unless: :login_admin
  before_action :authenticate_admin!, if: :login_admin
  before_action :set_user, only: %i[show edit update hide]
  before_action :correct_user, only: %i[edit update]

  def index
    @users = User.all
  end

  def show
    @chart = User.where(is_deleted: false).group("date(created_at)").count
    @oneday_lists = Todolist.only_done.where(update_date: @from..@to)
    @week_todolists = Todolist.where(time_category: 'week') # add
    @month_todolists = Todolist.where(time_category: 'month')
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to public_user_path(@user)
      flash[:notice] = "変更内容を保存しました"
    else
      render :edit
    end
  end

  def hide
    @user.update(is_deleted: true)
    #logout
    reset_session
    flash[:notice] = "退会済みです。"
    redirect_to root_path
  end

  def follows
    @user = User.find(params[:id])
    @users = @user.followers
 end

  def followers
    @user = User.find(params[:id])
    @users = @user.followings
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile_image, :introduction)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def correct_user
    user = User.find(params[:id])
    if current_user != user
      redirect_to public_user_path(current_user)
    end
  end

end
