class StoriesController < ApplicationController

  def index
    top_story_ids = helpers.fetch_top_stories.first(10)
    @stories = helpers.fetch_story_details(top_story_ids)
    @flagged_story_ids = current_user.flags.pluck(:story_id)

    @stories.each do |story|
      story_id = story['id']
      story['flagged'] = @flagged_story_ids.member?(story_id)
    end
  end

  def show
    story_id = params[:id]
    
    flag = current_user.flags.find_by(story_id: story_id)
    if flag
      notice = 'Story was successfully unflagged.'
      flag.destroy!
    else
      notice = 'Story was successfully flagged.'
      Flag.create!(story_id: story_id, user_id: current_user.id)
    end

    redirect_to(stories_path, notice: notice)
  end

end
