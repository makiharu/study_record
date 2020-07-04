class Manage::LabelsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_label, only: %i[edit update destroy]

  def new; end

  def create
    @label = Label.new(label_params)
    if @label.save
      redirect_to manage_labels_path
      flash[:notice] = "ラベルを追加しました"
    else
      redirect_back(fallback_location: root_path)
      flash[:alert] = "ラベルの追加に失敗しました"
    end
  end

  def index
    @label = Label.new
    @labels = Label.all.order(created_at: :desc).page(params[:page]).per(20)
  end

  def edit; end

  def update
    # binding.pry
    if @label.update(label_params)
      redirect_to manage_labels_path
      flash[:notice] = "タグの変更を保存しました"
    else
      render :edit
    end
  end

  def destroy
    if @label.destroy
      redirect_to manage_labels_path
      flash[:danger] = "タグを削除しました"
    else
      render :edit
    end
  end

  private

  def label_params
    params.require(:label).permit(:name, :is_void)
  end

  def set_label
    @label = Label.find(params[:id])
  end
end

