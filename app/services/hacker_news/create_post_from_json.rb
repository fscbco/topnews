module HackerNews
  class CreatePostFromJson
    attr_reader :data

    def initialize(data:)
      @data = data
    end

    def self.call(**args)
      self.new(**args).call
    end

    def call
      Post.create!(create_attributes)
    end

    private

    def create_attributes
      {
        author: data.dig('by'),
        hn_created_at: Time.at(data.dig('time')).to_datetime,
        hn_id: data.dig('id'),
        post_type: data.dig('type'),
        title: data.dig('title'),
        url: build_url,
      }
    end

    def build_url
      url = data.dig('url')
      return url if url

      # Some posts like Ask HN don't have a URL so we link to the page on
      # HackerNews instead
      "https://news.ycombinator.com/item?id=#{data.dig('id')}"
    end
  end
end
