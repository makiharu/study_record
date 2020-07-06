class Public::UsersController < ApplicationController
  before_action :authenticate_user!, unless: :login_admin
  before_action :authenticate_admin!, if: :login_admin
  before_action :set_user, only: %i[show edit update]

  def index
    @users = User.all
  end

  def show
    @chart = { @user.name => @user.todolists.count }

    @chart = User.where(is_deleted: false).group("date(created_at)").count

    @testdata = @user.todolists
    @data = User.all
    #userに紐づくラベルの内、リストが達成されている（done:true）ものの合計
    # @done_list_sum = @user.todolists.where(done: true).pluck(:done).count
    # #userに紐づくラベルの内、リストが達成されている（done:true）もの
    # @done_lists = @user.todolists.where(done: true)
    #@user_data= User.where(payment_result: 1).group("date(created_at)").count

    # @data = {'ラベル名' => 達成したリストの数...}
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
    params.require(:user).permit(:name, :email, :profile_image, :introduction)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
