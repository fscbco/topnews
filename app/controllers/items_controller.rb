class ItemsController < ApplicationController
  include ActionView::RecordIdentifier

  def index
    @items = Item.all.order(id: :desc) do |item|
      render turbo_stream: turbo_stream.prepend("items", target: "items_list", partial: "items/itemnew", locals: {item: item})
    end
  end

  def vote
    @item = Item.find(params[:id])
    
    if current_user.voted_for? @item
      @item.unliked_by current_user
    else
      @item.liked_by current_user
    end

    @item.broadcast_replace_to "items", partial: "items/itemvote", locals: { item: @item, voted_for: true }, target: dom_id(@item)+'true'
    @item.broadcast_replace_to "items", partial: "items/itemvote", locals: { item: @item, voted_for: false }, target: dom_id(@item)+'false'
    
    respond_to do |format|
      format.html {}
    end
  end

  def refeed
    refresh_news

    head :no_content
  end

  private

  def refresh_news
    NewsClient.new.news_update
  end
end
