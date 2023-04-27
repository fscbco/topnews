# frozen_string_literal: true

module ApiHelper
  def api_call
    uri = URI('https://hacker-news.firebaseio.com/v0/topstories.json')
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body)
  end
end
