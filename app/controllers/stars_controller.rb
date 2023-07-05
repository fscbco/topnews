class StarsController < ApplicationController

    def star_article
        ArticleStarer.call(star_params['user_id'], star_params['story_id'])
        redirect_to '/'
    end

private
    def star_params
        params.permit(:user_id, :story_id)
    end
end
