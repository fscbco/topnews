
class PollHackerNewsJob
  include Sidekiq::Job

  def perform(*args)
    puts 'polling Hacker News'
    ## If no news deatilas exist create intial set of them
    
    if NewsDetail.count == 0 
      result = HackerNews::GetStoryIds.new.call
      result.data.each do |story_id|
        HackerNews::CreateItemDetail.new(story_id).call
      end
    end
    most_recent_story =  NewsDetail.most_recent_story.try(:hn_id) || 0
    if  most_recent_story < HackerNews::Base.new.newest_story_id  
      puts "adding new story"    
           
      story_id_result = HackerNews::GetStoryIds.new.call
      
      story_ids = story_id_result.data
      result = HackerNews::AddNewStories.new(story_ids).call  

      puts "#{result.success? ? ' New stories added' : result.errors}"
    else
      puts 'No new stories'
    end

  end
  
end
