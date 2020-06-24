# frozen_string_literal: true

class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show edit update]

  def index
  	@user = current_user.id
  end

  def show
  end

  def edit
  end

  def update
  	if @user.update(user_params)
  		redirect_to public_user_path(@user)
  		flash[:notice] = "success!"
  	else
  		render :edit
  	end
  end



  def complete; end

  private

  def user_params
  	params.require(:user).permit(:name, :email, :profile_image)
  end

  def set_user
  	@user = User.find(params[:id])
  end
end