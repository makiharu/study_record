# frozen_string_literal: true

class Public::UsersController < ApplicationController

  def index
  end

  def show
  	@user = User.find(params[:id])
  end
  def complete; end
end
