class LoginController < ApplicationController

  def create
  	Rails.logger.info("zzz")
    if user = User.authenticate(params[:username], params[:password])
      Rails.logger.info(params)
      # Save the user ID in the session so it can be used in
      # subsequent requests
      session[:current_user_id] = user.id
      redirect_to root_url
    end
  end

  def delete
  	Rails.logger.info("zzz1")
  	session[:current_user_id] = nil
  end
end
