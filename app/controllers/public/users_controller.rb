class Public::UsersController < ApplicationController
  before_action :authenticate_user!, unless: :login_admin
  before_action :authenticate_admin!, if: :login_admin
  before_action :set_user, only: %i[show edit update hide follows followers]
  before_action :correct_user, only: %i[edit update]

  def index
    @users = User.all
  end

  def show
    @oneday_lists = Todolist.only_done.where(update_date: @from..@to)
    @week_todolists = @user.todolists.week
    @month_todolists = @user.todolists.month
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
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
    @users = @user.followings
 end

  def followers
    @users = @user.followers
  end

  def edit_password #password_change
    @user = User.new
    @pass_user = User.find(params[:user_id])
  end

  def update_password #password_change
    if current_user.update_with_password(pass_params)
        redirect_to root_path, success: 'パスワードを変更しました。再度ログインしてご利用くださいませ。'
      else
        render :edit_password
    end
  end

  def user_boards
    @boards = current_user.boards
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
      redirect_to user_path(current_user)
    end
  end

    #パスワード変更用
  def pass_params
      params.require(:user).permit(:password, :password_confirmation, :current_password)
  end

end
