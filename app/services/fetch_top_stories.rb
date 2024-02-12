class FetchTopStories
  def self.call(hacker_news_api: HackerNewsApi)
    top_story_ids = hacker_news_api.get_top_story_ids

    top_story_ids.each do |story_id|
      next if Story.find_by(external_id: story_id)

      story_details = hacker_news_api.get_story(story_id)

      Story.create!(
        external_id: story_id,
        author: story_details["by"],
        title: story_details["title"],
        url: story_details["url"],
      )
    end
  end
end
