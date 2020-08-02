class Public::TodolistsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_todolist, only: %i[edit update destroy clear]
  before_action :time_todolist, only: %i[create index clear]
  def new
    @todolist = Todolist.new
    @todolists = Todolist.all
  end

  def create
    todolist = Todolist.new(todolist_params)
    todolist.user_id = current_user.id
    todolist.save
    # Ajax 追加
    @todolist = Todolist.new
    @todolist.label_lists.build
    @label = Label.valid
  end

  def index
    @todolist = Todolist.new
    @todolist.label_lists.build
  end

  def edit
  end

  def update
    @todolist.user_id = current_user.id
    if @todolist.update(todolist_params)
      redirect_to todolists_path
      flash[:notice] = "内容を保存しました"
    else
      render :edit
    end
  end

  def clear # Ajax 追加
    @todolist.update(done: true, update_date: Time.now)
    @todolist.label_lists.build
    @label = Label.valid
  end


  def destroy
    if @todolist.destroy
      redirect_to todolists_path
      flash[:alert] = "削除しました"
    else
      render :edit
    end
  end


  private

  def todolist_params
    params.require(:todolist).permit(:content, :time_category, :update_date,:done, label_lists_attributes: [:label_id])
  end

  def set_todolist
    @todolist = Todolist.find(params[:id])
  end

  def time_todolist
    @today_todolists = current_user.todolists.today
    @week_todolists = current_user.todolists.week
    @month_todolists = current_user.todolists.month
  end

end
