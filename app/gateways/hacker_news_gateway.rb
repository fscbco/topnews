class HackerNewsGateway
  def initialize(api=HackerNewsApi)
    @api = api
  end

  def top_stories(count = 10)
    # Fetch all top story ids, truncate to requested number
    ids = @api.top_story_ids[0...count]
    # Initialize story objects
    @api.fetch_stories(ids).map { |s| find_or_create_story(s) }
  end

  private

  def find_or_create_story(hash)
    hash.transform_keys!(&:to_sym)
    args = hash.slice(:by, :score, :title, :url)
    args[:time] = Time.at(hash[:time])
    HackerNewsStory
      .create_with(args)
      .find_or_create_by(hacker_news_id: hash[:id])
  end
end
