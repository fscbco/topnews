class UsersController < ApplicationController

  skip_before_action :verify_authenticity_token, raise: false
  before_action :authenticate_user!

  def update
    head :forbidden if params[:id] != current_user.id.to_s
    params.permit(:first_name, :last_name, :email, :id)
    @user = User.find(params[:id])
    @user.update_mutable(params.slice(:first_name, :last_name, :email))
    render :show
  end
end
