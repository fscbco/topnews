class ItemsController < ApplicationController
  include ActionView::RecordIdentifier
  include ActionView::Helpers::TextHelper
  before_action :refresh_news, only: %i[index]

  def index
    @items = Item.all
  end

  def vote
    @item = Item.find(params[:id])
    
    if current_user.voted_for? @item
      @item.unliked_by current_user
    else
      @item.liked_by current_user
    end

    puts pluralize(@item.votes_for.size, 'vote') + " for item #{@item.id}"

    @item.broadcast_replace_to "items", partial: "items/itemvote", locals: { item: @item, voted_for: true }, target: dom_id(@item)+'true'
    @item.broadcast_replace_to "items", partial: "items/itemvote", locals: { item: @item, voted_for: false }, target: dom_id(@item)+'false'
    
    respond_to do |format|
      format.html {}
    end
  end

  def refresh_news
    NewsClient.new.news_update
  end
end
