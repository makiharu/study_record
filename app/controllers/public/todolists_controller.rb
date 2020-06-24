# frozen_string_literal: true

class Public::TodolistsController < ApplicationController

  before_action :authenticate_user!

  def complete; end
end
