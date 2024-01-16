class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def authenticate_user!
    if !user_signed_in?
      super
    else
    end
  end
end
