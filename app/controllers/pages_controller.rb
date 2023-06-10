class PagesController < ApplicationController
  before_action :authenticate_user!

  def home
    redirect_to stories_path
  end
end
