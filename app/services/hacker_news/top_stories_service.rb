module HackerNews
  class TopStoriesService
    attr_reader :client
    def initialize
      @client = Client.new
    end

    def call
      client.handle_response client.top_stories
    end
  end
end
