# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!

  def fetch_current_user
    render json: current_user
  end
end
