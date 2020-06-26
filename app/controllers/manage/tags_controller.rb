class Manage::TagsController < ApplicationController
  before_action :set_tag, only: %i[edit update destroy]

  def new
  	@tag = Tag.new
  end

  def create
  	@tag = Tag.new(tag_params)
  	if @tag.save
  		redirect_to manage_tags_path
  		flash[:notice] = "タグを追加しました"
  	else
  		render :new
  	end
  end

  def index
  	@tag = Tag.new
  	@tags = Tag.all.order(created_at: :desc).page(params[:page]).per(20)
  end

  def edit; end

  def update
  	if @tag.update(tag_params)
  		redirect_to manage_tags_path
  		flash[:notice] = "タグを編集しました"
  	else
  		render :edit
  	end
  end

  def destroy; end

  private

  def tag_params
  	params.require(:tag).permit(:name, :is_void)
  end

  def set_tag
  	@tag = Tag.find(params[:id])
  end
end
