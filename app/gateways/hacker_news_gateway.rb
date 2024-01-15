class HackerNewsGateway
  def initialize(api=HackerNewsApi)
    @api = api
  end

  def top_stories(count = 10)
    # Fetch all top story ids, truncate to requested number
    ids = @api.top_story_ids[0...count]
    # Initialize story objects
    @api.fetch_stories(ids).map { |s| initialize_story(s) }
  end

  private

  def initialize_story(hash)
    hash.transform_keys!(&:to_sym)
    args = hash.slice(:by, :id, :score, :title, :url)
    HackerNewsStory.new(time: Time.at(hash[:time]), **args)
  end
end
