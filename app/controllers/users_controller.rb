class UsersController < ApplicationController
  def initialize(*)
    super
  end

  def show
    @user = User.where(id: params[:id]).last
  end

end
