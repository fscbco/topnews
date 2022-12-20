# Returns the top news stories from 1-n feed sources as a Hash.
class TopNewsService
  include Limitable

  def initialize(limit: nil)
    validate_limit!

    @limit = limit
  end

  def execute
    # TODO: Add other news feed sources as needed and refactor
    # the limit logic accordingly (e.g. split 1 + n feed source
    # results according to limit).
    ids = Feeds::HackerNews::TopStories.new(limit: limit).execute
    Feeds::HackerNews::StoriesWithDetail.new(ids).execute
  end
end
