class NewsItemsController < ApplicationController
  def index
    @news_items = NewsItem.all
  end

  def create
    @news_item = NewsItem.find_or_initialize_by(hacker_news_id: params[:hacker_news_id], title: params[:title], url: params[:url], item_type: params[:type])
    @news_item.favorites.build(user_id: current_user.id)
    if @news_item.save
      redirect_to news_items_url
    end
  end
end
