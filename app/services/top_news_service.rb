# Returns the top news stories from 1-n feed sources as a Hash.
class TopNewsService
  include Limitable

  DEFAULT_LIMIT = 500

  def initialize(limit: 500)
    @limit = limit || DEFAULT_LIMIT

    validate_limit!
  end

  def execute
    # TODO: Add other news feed sources as needed and refactor
    # the limit logic accordingly (e.g. split 1 + n feed source
    # results according to limit).
    ids = Feeds::HackerNews::TopStories.new(limit: limit).execute
    Feeds::HackerNews::StoriesWithDetail.new(ids).execute
  end
end
