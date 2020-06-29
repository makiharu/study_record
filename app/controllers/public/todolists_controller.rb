class Public::TodolistsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_todolist, only: %i[edit update destroy]

  def new
    @todolist = Todolist.new
    @todolists = Todolist.all
  end

  def create
    binding.pry
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
    #binding.pry
    #ラジオボタンが0番,1番,2番で振り分けたい
    if params[:time_category] == 'today'
    #params[:time_category] == 0
      #params[:time_category][:today]
      @todolists = Todolist.wherer(time_category: 'today')
    elsif params[:time_category] == 1
      #params[:time_category][:week]
      @todolists = Todolist.wherer(time_category: 1)
    elsif params[:time_category] == 2
      #params[:time_category][:month]
      @todolists = Todolist.wherer(time_category: 2)
    else
      @todolists = Todolist.all
    end

    @finish_list = Todolist.new
  end

  def complete
    @todolists = Todolist.all
    # checkboxから値が送られてきたら、そのデータを非表示にする
    @finish_list = Todolist.new
    @finish_list.user_id = current_user.id
    if @finish_list.save
      redirect_to root_path
      #redirect_to public_todolists_complete_path
      flash[:notice] = "報告完了しました"
    else
      redirect_to public_todolists_path
      flash[:alert] = "もう一度やり直してください"
    end
  end


  def edit; end

  def update
    if @todolist.update(todolist_params)
      redirect_to public_todolists_complete_path
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
    params.require(:todolist).permit(:content, :time_category)
  end

  # def finish_list_params
  #   params.require(:todolist).permit(:todolist_id)
  # end

  def set_todolist
    @todolist = Todolist.find(params[:id])
  end
end
