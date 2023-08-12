class PagesController < ApplicationController
  def home
    @page_count = params[:page_count] || 1

    @feed = YcConnector.new.build_feed(page: @page_count.to_i)
    @liked_feed = Post.joins(:user)
                      .order(:created_at)
                      .reverse_order
                      .select(:item_id, :user_id, :title)
                      .group_by(&:item_id)
  end
end