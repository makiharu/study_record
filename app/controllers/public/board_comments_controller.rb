# frozen_string_literal: true

class Public::BoardCommentsController < ApplicationController

  before_action :authenticate_user!

  def index; end

  def edit; end
end
