class PagesController < ApplicationController
  before_action :authenticate_user!

  def home
    story_list = Rails.cache.fetch("story_order", expires_in: 15.minutes) do
      refresh_stories.first(50)
    end

    @stories = Story.where(external_id: story_list)
                    .left_joins(:stars)
                    # maintain story order
                    .order(Arel.sql("position(external_id::text in '#{story_list.join(',')}')"))
                    .select("stories.id, stories.title, stories.url, stories.external_id,
                      user_stories.user_id = #{current_user.id} as starred, user_stories.id as starred_id")
  end

  def star_story
    new_star = UserStory.new(user: current_user, story_id: params[:id])

    if new_star.save
      redirect_to "/stars"
    else
      redirect_to '/', notice: "You can't star that story anymore!"
    end
  end

  def unstar_story
    star = current_user.stars.find(params[:id])

    if star&.delete
      redirect_to '/'
    else
      redirect_to '/stars', notice: "Sorry, you can't delete that star!"
    end
  end

  def starred_stories
    @stories = Story.joins(:stars).uniq 
  end

  private

  def refresh_stories
    HackerNews::Api.refresh_stories
  end
end
