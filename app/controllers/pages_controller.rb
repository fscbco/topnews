class PagesController < ApplicationController

    def home 
        @user = current_user
        @user_articles = current_user.articles
        @articles = Article.new_articles
    end

    def favorites
        @user = current_user
        @favorites = @user.articles
    end
end
