class NewsController < ApplicationController
    def flag
      news_id = params[:news_id]
      user_first_name = params[:user_name]
      @news = News.find(news_id)
      if @news.names.include? user_first_name
        redirect_to '/news', notice: 'You have already flagged this news'
      end
      @news.names << user_first_name
      if @news.save
        redirect_to '/news', notice: 'News flagged successfully.'
      else
        redirect_to '/news', notice: 'Invalid User Email, please log in again or create a new account if persists'
      end
    end
end
  