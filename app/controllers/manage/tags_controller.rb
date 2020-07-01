class Manage::TagsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_tag, only: %i[edit update destroy]

  def new; end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to manage_tags_path
      flash[:notice] = "タグを追加しました"
    else
      redirect_back(fallback_location: root_path)
      flash[:alert] = "タグが追加できていません"
    end
  end

  def index
    @tag = Tag.new
    @tags = Tag.all.order(created_at: :desc).page(params[:page]).per(20)
  end

  def edit
    #  @tags = Tag.all.order(created_at: :desc).page(params[:page]).per(20)
  end

  def update
    # binding.pry
    if @tag.update(tag_params)
      redirect_to manage_tags_path
      flash[:notice] = "タグの変更を保存しました"
    else
      render :edit
    end
  end

  def destroy
    if @tag.destroy
      redirect_to manage_tags_path
      flash[:danger] = "タグを削除しました"
    else
      render :edit
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
