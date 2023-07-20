class PagesController < ApplicationController

    ARTICLES_TO_DISPLAY = 10
    
    def home
        # I would like to put it in some sort of cron job if I have enough time (Clockwork)
        Hackerrank::Client.new.call

        # eager load the reference table so we can display all emails that favorited the article
        @most_recent_articles = Headline.includes(:user_favorite).last(ARTICLES_TO_DISPLAY).sort_by(&:favorites).reverse
        @favorited_headlines = current_user.user_favorite.map { |user_favorite| user_favorite.headline_id}
    end

    def like
        @headline = Headline.find(params[:id])
        @headline.add_favorite
        @headline.user_who_favorited(current_user.id)
        redirect_to root_path
    end
end
