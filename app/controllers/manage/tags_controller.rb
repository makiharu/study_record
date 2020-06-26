# frozen_string_literal: true

class Manage::TagsController < ApplicationController
  def new
  	@tag = Tag.new
  end

  def index
  	@tags = Tag.all.page(params[:page]).per(20)
  end

  def edit; end

  def update; end

  def destroy; end
end
