class StoriesController < ApplicationController
  def initialize(*)
    super
    @stories = client.topstories(0, 10)

    @stories.each do |story|
      Rails.logger.info story['id']
      Rails.logger.info story['time']
      if story['type'] == 'story'
        s = Story.where(hackernewsid: story['id']).first_or_initialize
        s.author = story['by']
        s.title = story['title']
        s.hn_created_at = Time.at(story['time'].to_i).to_datetime
        s.url = story['url']
        s.save!
      end
    end
  end

  def top
    @stories = Story.last(10)
  end

  def like
    @story = Story.all.find(params[:id])
    Like.create(user_id: current_user.id, story_id: @story.id)
    redirect_to '/'
  end
end
