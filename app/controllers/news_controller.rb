class NewsController < ApplicationController
    def flag
      @news = News.find(params[:id])
      @news.update(flagged: true)
      ActionCable.server.broadcast('news_flags', { article_id: @article.id })
      redirect_to @article, notice: 'News flagged successfully.'
    end
    def news:
    end
  end
  