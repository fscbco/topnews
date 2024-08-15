class PagesController < ApplicationController
  def home
    redirect_to stories_view_url if user_signed_in?
  end
end
