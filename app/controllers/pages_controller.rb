class PagesController < ApplicationController

  def home
    news_service = ApiClient.new  
    
    @hacker_news_items = news_service.top_stories
  end
end
