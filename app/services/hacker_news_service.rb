class HackerNewsService
  HN_TOP_STORIES_URL = 'https://hacker-news.firebaseio.com/v0/topstories.json'
  HN_ITEM_URL = 'https://hacker-news.firebaseio.com/v0/item/%<id>d.json'

  def fetch_top_stories(limit = 15)
    # TODO: Add pagination or lazy load
    top_ids = fetch_top_story_ids.first(limit)
    top_ids.map { |id| fetch_story_details(id) }.compact
  end

  private

  def fetch_top_story_ids
    response = Faraday.get(HN_TOP_STORIES_URL)
    JSON.parse(response.body) if response.success?
  rescue
    []
  end

  def fetch_story_details(story_id)
    response = Faraday.get(format(HN_ITEM_URL, id: story_id))
    JSON.parse(response.body).slice('id', 'title', 'url').transform_keys(&:to_sym) if response.success?
  rescue
    nil
  end
end