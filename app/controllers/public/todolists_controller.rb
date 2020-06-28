class Public::TodolistsController < ApplicationController

  before_action :authenticate_user!

  def new
  	@todolist = Todolist.new
  end

  def create
  	@todolist = Todolist.new(todolist_params)
  	@todolist.user_id = current_user.id
  	if @todolist.save
  		redirect_to public_user_path(@todolist.user_id)
  		flash[:notice] = "todoリストを作成しました"
  	else
  		render :index
  	end

  end

  def index
  	@todolists = Todolist.all
  end

  def complete; end

  private

  def todolist_params
  	params.require(:todolist).permit(:content)
  end
end

