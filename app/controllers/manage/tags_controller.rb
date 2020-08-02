class Manage::TagsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_tag, only: %i[edit update destroy]

  def new; end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to tags_path
      flash[:notice] = "タグを追加しました"
    else
      redirect_back(fallback_location: root_path)
      flash[:alert] = "タグの追加に失敗しました"
    end
  end

  def index
    @tag = Tag.new
    @tags = Tag.all.order(created_at: :desc).page(params[:page]).per(20)

    if params[:is_void] == "false"
      @tags = Tag.all.where(is_void: false).page(params[:page]).per(20)
    elsif params[:is_void] == "true"
      @tags = Tag.all.where(is_void: true).page(params[:page]).per(20)
    else
      @tags = Tag.all.order(created_at: :desc).page(params[:page]).per(20)
    end
  end

  def edit; end

  def update
    if @tag.update(tag_params)
      redirect_to tags_path
      flash[:notice] = "タグの変更を保存しました"
    else
      render :edit
    end
  end

  def destroy
    if @tag.destroy
      redirect_to tags_path
      flash[:alert] = "タグを削除しました"
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:name, :is_void)
  end

  def set_tag
    @tag = Tag.find(params[:id])
  end

end
