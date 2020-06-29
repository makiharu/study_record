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
      flash[:notice] = "todoリストを作成しました"
    else
      @todolists = Todolist.all
      redirect_back(fallback_location: root_path)
      flash[:warning] = "もう一度やり直してください"
    end
  end

  def index
    #@todolists = Todolist.all
    @todolist = Todolist.new
    @todolists = Todolist.all
    @finish_list = Todolist.new

    if params[:todolist_id]
      @finish_list = Todolist.find(params[:todolist_id])
      @todolists = Todolist.all
    end
  end

  def complete
    # checkboxから値が送られてきたら、そのデータを非表示にする
    @finish_list = Todolist.new
    @finish_list.user_id = current_user.id
    if @finish_list.save
      #redirect_to public_user_path(@finish_list.user_id)
      redirect_back(fallback_location: root_path)
      flash[:notice] = "報告完了しました"
    else
      render :index
    end
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

  # def finish_list_params
  #   params.require(:todolist).permit(:todolist_id)
  # end

  def set_todolist
    @todolist = Todolist.find(params[:id])
  end
end
