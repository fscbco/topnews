class ArticlesController < ApplicationController

    def show 
        @article = Article.find(params[:id])
    end

    def favorite 
        @user = current_user
        @article = Article.find(params[:id])
        unless @user.articles.find {|a| a.id == params[:id].to_i }
            @user.articles << @article
        end
        redirect_to root_path 
    end
end
