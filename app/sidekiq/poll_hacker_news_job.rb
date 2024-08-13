
class PollHackerNewsJob
  include Sidekiq::Job

  def perform(*args)
    if NewsDetail.count == 0 

      

      story_ids = HackerNews::Base.new.get_new_stories

      JSON.parse(story_ids.body).each do |story|
        HackerNews::CreateItemDetail.new(story).call
      end
    end

    if NewsDetail.most_recent_story.hn_id < HackerNews::Base.new.newest_story_id  
      puts "adding new story"    
      HackerNews::AddNewStories.new.call  
    end

  end
  
end
