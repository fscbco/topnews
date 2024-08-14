class Api::V1::AuthController < ApplicationController
  skip_before_action :verify_authenticity_token

  def login
    user = User.find_by(email: params[:email].downcase)
    
    if user.nil?
      render json: { error: 'User not found' }, status: :unauthorized
    elsif user.valid_password?(params[:password])
      token = JsonWebToken.encode(user_id: user.id)
      render json: { token: token, user_id: user.id }, status: :ok
    else
      render json: { error: 'Invalid password' }, status: :unauthorized
    end
  end

  def logout
    render json: { message: 'Logged out successfully' }, status: :ok
  end
end