class StoriesController < ApplicationController
  before_action :update, only: %i[index, show]

  private
  
  def update
    HackerRankNews.new.get_top_stories.first(25).each do |story_id|
      story = Story.find_or_initialize_by(story_id: story_id)
      story.hr_news_story
      story.save if story.valid?
    end
  end

end
