class PagesController < ApplicationController
  def home
    @page_count = params[:page_count] || 1
    @feed = YcConnector.new.build_feed(page: @page_count.to_i)
    @liked_feed = Post.all.order(:created_at).reverse_order
  end
end
