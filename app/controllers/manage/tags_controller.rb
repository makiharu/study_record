# frozen_string_literal: true

class Manage::TagsController < ApplicationController
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

  def update; end

  def destroy; end

  private

  def tag_params
  	params.require(:tag).permit(:name, :is_void)
  end
end
