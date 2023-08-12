class PagesController < ApplicationController
  def home
    @feed = YcConnector.new.build_feed
    @liked_feed = Post.all
  end
end
