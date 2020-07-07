class Public::UsersController < ApplicationController
  before_action :authenticate_user!, unless: :login_admin
  before_action :authenticate_admin!, if: :login_admin
  before_action :set_user, only: %i[show edit update hide]

  def index
    @users = User.all
  end

  def show
    @chart = User.where(is_deleted: false).group("date(created_at)").count

    # from = Time.now.in_time_zone("Tokyo").beginning_of_day
    # to = Time.now.in_time_zone("Tokyo").end_of_day
    @oneday_lists = Todolist.only_done.where(update_date: @from..@to)

    #@day_count = @oneday.group("YEAR(created_at)").group("MONTH(created_at)").count
   #userに紐づくラベルの内、リストが達成されている（done:true）ものの合計
  # @done_list_sum = @user.todolists.where(done: true).pluck(:done).count
  # @data = {'2020-07-01' => 5, '2020-07-02' => 4, '2020-07-03' => 10 }
    # {'1day' => 達成したリストの数...}
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
    @users = @user.followings
 end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile_image, :introduction)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
