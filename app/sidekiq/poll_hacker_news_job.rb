
class PollHackerNewsJob
  include Sidekiq::Job

  def perform(*args)
    puts 'polling Hacker News'
    ## If no news deatilas exist create intial set of them
    if NewsDetail.count == 0 
      story_ids = HackerNews::Base.new.get_new_stories
      JSON.parse(story_ids.body).each do |story|
        HackerNews::CreateItemDetail.new(story).call
      end
    end

    if HackerNews::Base.new.newest_story_id < HackerNews::Base.new.newest_story_id  
      puts "adding new story"    
      HackerNews::AddNewStories.new.call  
    else
      puts 'No new stories'
    end

  end
  
end
