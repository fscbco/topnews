class CurrentUserController < ApplicationController
  before_action :authenticate_user!
  def index
    @user = current_user
    render "users/show"
  end
end