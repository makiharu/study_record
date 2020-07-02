class Manage::TodolistsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_todolist, only: %i[edit update destroy]

  def new
    @todolist = Todolist.new
  end

  # def create
  #   @todolist = Todolist.new(todolist_params)
  #   if @todolist.save
  #     redirect_to manage_todolists_path
  #     flash[:notice] = "タグを追加しました"
  #   else
  #     redirect_back(fallback_location: root_path)
  #     flash[:alert] = "タグが追加できていません"
  #   end
  # end

  def index
    @todolist = Todolist.new
    @todolists = Todolist.all.order(created_at: :desc).page(params[:page]).per(20)
  end

  def edit
    @todolists = Todolist.all.order(created_at: :desc).page(params[:page]).per(20)
  end

  def update
    if @todolist.update(todolist_params)
      redirect_to manage_todolists_path
      flash[:notice] = "タグの変更を保存しました"
    else
      render :edit
    end
  end

  def destroy
    if @todolist.destroy
      redirect_to manage_todolists_path
      flash[:danger] = "タグを削除しました"
    else
      render :edit
    end
  end

  private

  def todolist_params
    params.require(:todolist).permit(:content, :label, :done)
  end

  def set_todolist
    @todolist = Todolist.find(params[:id])
  end
end
