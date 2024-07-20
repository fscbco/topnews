class HackerNewsStoryRecorder
  include ActiveModel::Model
  REQUIRED_KEYS = %w[id by score time title url]

  attr_accessor :api_response

  validates :api_response, presence: true
  validate :api_response_is_hacker_news_story

  def execute
    return false if invalid?

    hacker_news_story_record = HackerNewsStory.find_or_initialize_by(hacker_news_id: api_response['id'])
    hacker_news_story_record.update(
      hacker_news_id: api_response['id'],
      author: api_response['by'],
      score: api_response['score'],
      hacker_news_timestamp: api_response['time'],
      title: api_response['title'],
      url: api_response['url']
    )
  end

  private

  def api_response_is_hacker_news_story
    return errors.add(:api_response, 'is not a HTTParty::Response') unless api_response.is_a?(HTTParty::Response)
    return errors.add(:api_response, 'is missing required keys') unless REQUIRED_KEYS.all? { |key| api_response.key?(key) }
  end
end
