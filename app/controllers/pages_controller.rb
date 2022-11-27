class PagesController < ApplicationController
    HACKER_NEWS_STORY_URL = "https://news.ycombinator.com/item?id=".freeze

    def home
        # The home method displays 2 lists of stories upon successful sign in:
        # The 1st list is the list of the latest top stories pulled from Hacker News
        # The 2nd list is the list of favorite stories tagged as favorites by signid in users

        @users = User.all
        @max_stories = 30

        hacker_news_client = HackerNewsApi::V0::Client.new('')

        res = hacker_news_client.top_stories

        @hacker_news_story_url = HACKER_NEWS_STORY_URL
        
        @story_ids = res
        @stories = []

        @story_ids.each_with_index do |story_id, idx|
            @stories.push(hacker_news_client.story_details(story_id))
            break if idx == @max_stories
        end        

        @favorites = Favorite.all
        @favorite_stories = []

        @favorites.each_with_index do |fav, idx|
            fav_story = {}

            fav_story["story"] = hacker_news_client.story_details(fav.story_id)
            fav_story["users"] = User.find(Favorite.where(story_id: fav.story_id).pluck(:user_id)).pluck(:first_name, :last_name)

            @favorite_stories.push(fav_story)
        end

    end
end
