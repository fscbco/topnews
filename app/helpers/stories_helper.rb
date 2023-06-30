module StoriesHelper
 def story_details(story_id)
  HackerNewsApi.get_story_details(story_id)
 end

 def story_title(story_id)
  story = story_details(story_id)
  story['title']
 end

 def story_url(story_id)
  story = story_details(story_id)
  story['url']
 end
end
