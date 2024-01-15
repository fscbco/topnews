class HackerNewsGateway
  def initialize(api=HackerNewsApi)
    @api = api
  end

  def top_story_ids(count = 10)
    # Fetch all top story ids, truncate to requested number
    ids = @api.top_story_ids[0...count]

    # Fetch the story details corresponding to those ids
    stories = @api.fetch_stories(ids)
      # Filter down to only stories; ads are included in topstories endpoint
      .filter { |s| s["type"] == "story" }
      # Convert the deserialized JSON into a hash we can use to create a record
      .map { |s| prepare_for_upsert(s) }

    HackerNewsStory.upsert_all(stories, unique_by: :hacker_news_id)
    stories.pluck(:hacker_news_id)
  end

  private

  def prepare_for_upsert(hash)
    hash.transform_keys!(&:to_sym)
    args = hash.slice(:by, :score, :title, :url)
    # AskHN posts have no URL
    args[:url] = args[:url] || "https://news.ycombinator.com/item?id=#{hash[:id]}"
    args[:time] = Time.at(hash[:time])
    args[:hacker_news_id] = hash[:id]
    args
  end
end
