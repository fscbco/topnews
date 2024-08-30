class PagesController < ApplicationController

  def home
    stories_flagged = Flag.stories_flagged()
    @stories = helpers.fetch_story_details(stories_flagged.keys)
    @stories.each do |story| 
      story_id = story['id']
      story['flags'] = stories_flagged[story_id].map(&:user).map(&:email).join(', ') if stories_flagged[story_id]
    end
  end

end
