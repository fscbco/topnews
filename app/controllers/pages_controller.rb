class PagesController < ApplicationController
    before_action :authenticate_user!
    def news
        @top_stories = News.all.order(created_at: :desc)
        @flagged_stories = News.where.not(names: '{}')
        puts News.where.not(names: '{}')
        NewsService.fetch_and_reload_news
    end
end
