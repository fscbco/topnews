module HackerNewsApi
 require 'httparty'

 def self.get_all_stories
   response = HTTParty.get('https://hacker-news.firebaseio.com/v0/topstories.json')
   JSON.parse(response.body)
 end

 def self.get_story_details(story_id)
   response = HTTParty.get("https://hacker-news.firebaseio.com/v0/item/#{story_id}.json")
   JSON.parse(response.body)
 end
end
