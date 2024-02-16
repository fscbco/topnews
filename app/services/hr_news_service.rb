class HrNewsService
  def self.fetch_and_update_stories(limit = 25)
      hr_news_stories = HackerRankNews.new
      hr_news = hr_news_stories.get_top_stories.first(limit)

      hr_news.each do |story_id|
          single_story = hr_news_stories.get_story(story_id)

      story = Story.find_or_initialize_by(story_id: story_id)
      story.assign_attributes(
          title: single_story["title"],
          by: single_story["by"],
          text: single_story["text"],
          url: single_story["url"],
          score: single_story["score"],
          time: single_story["time"]
      )
      story.save
    end
  end
end