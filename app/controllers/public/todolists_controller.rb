class Public::TodolistsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_todolist, only: %i[edit update destroy]

  def new
    @todolist = Todolist.new
    @todolists = Todolist.all
  end

  def create
    @todolist = Todolist.new(todolist_params)
    @todolist.user_id = current_user.id
    if @todolist.save
      redirect_to public_todolists_path
      flash[:notice] = "リストを作成しました"
    else
      @todolists = Todolist.all
      redirect_back(fallback_location: root_path)
      flash[:warning] = "作成できませんでした。リスト内容は30文字以内です。"
    end
  end

  def index
    @todolist = Todolist.new
    @todolist.label_lists.build
    # ラジオボタンで場合分けをするよりも変数名を別にした方がわかりやすい
    @today_todolists = Todolist.where(time_category: 'today')
    # @week_todolists = Todolist.where(time_category: 'week')
    # @month_todolists = Todolist.where(time_category: 'month')
  end

  def edit; end

  def update
    if @todolist.update(todolist_params)
      redirect_to public_todolists_path
      flash[:notice] = "内容を保存しました"
    else
      render :edit
    end
  end

  def destroy
    if @todolist.destroy
      redirect_to public_todolists_path
      flash[:alert] = "削除しました"
    else
      render :edit
    end
  end

  def empty
    user = User.find(current_user.id)
    today_todolists = Todolist.where(time_category: 'today', user_id: user.id)
    today_todolists.destroy_all
    redirect_to public_todolists_path, danger: "１日分のリストを全てリセットしました"
  end

  def compelte
   # bindign.pry
    @completed_list = Todolist.new(completed_params)
    @compeleted_list.save
    # @finished_lists = Todolist.where(time_category: "today")
    # @finishe_list = Todolist.find_by(done: params[:todolist][:time_category])
  end

  private

  def todolist_params
    params.require(:todolist).permit(:content, :time_category, :done, label_lists_attributes: [:label_id])
  end

  def completed_params
    params.require(:todolist).permit(:id, :content, :time_category, :label)
  end

  def set_todolist
    @todolist = Todolist.find(params[:id])
  end
end
