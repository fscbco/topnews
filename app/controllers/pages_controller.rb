class PagesController < ApplicationController
  def home
    @stories = HackerNewsService.new.top_stories
    @stories.each do |story|
      Story.find_or_create_by(:title => story["title"], :id => story['id'], :user_id => current_user.id, :url => story['url'], :author => story['by'])
    end
  end
end
