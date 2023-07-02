class StarsController < ApplicationController

    def star_article
        ArticleStarer.call(star_params['user_id'], star_params['story_id'])
        redirect_to '/'
    end
end
