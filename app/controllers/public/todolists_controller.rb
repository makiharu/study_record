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
  		redirect_to public_user_path(@todolist.user_id)
  		flash[:notice] = "todoリストを作成しました"
  	else
      @todolists = Todolist.all
  		redirect_back(fallback_location: root_path)
      flash[:warning] = "もう一度やり直してください"
  	end
  end

  def index
  	@todolists = Todolist.all
  end

  def complete
    #checkboxから値が送られてきたら、そのデータを非表示にする
    @todolist = Todolist.new(todolist_params)
    @todolist.user_id = current_user.id
    if @todolist.save
      redirect_to public_user_path(@todolist.user_id)
      flash[:notice] = "todoリストを作成しました"
    else
      render :index
    end
  end

  def edit

  end

  def update
    if @todolist.update(todolist_params)
      redirect_to public_user_path(@todolist.user_id)
      flash[:notice] = "内容を保存しました"
    else
      render :edit
    end
  end

  def destroy
    if @todolist.destroy
      redirect_to public_user_path(@todolist.user_id)
      flash[:alert] = "削除しました"
    else
      render :edit
    end
  end



  private

  def todolist_params
  	params.require(:todolist).permit(:content)
  end

  def set_todolist
    @todolist = Todolist.find(params[:id])
  end
end

