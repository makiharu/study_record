# frozen_string_literal: true

class Manage::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all.order(created_at: :desc).page(params[:page]).per(20)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to manage_user_path(@user)
      flash[:notice] = '変更内容を保存しました'
    else
      render :edit

    end
  end

  def hide; end

  private

  def user_params
    params.require(:user).permit(:name, :email, :is_deleted)
  end
end
