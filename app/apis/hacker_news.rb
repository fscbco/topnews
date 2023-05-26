class HackerNews
	
	class << self
		HACKER_NEWS_ROOT = 'https://hacker-news.firebaseio.com/v0'.freeze

		def top_stories
			request(path: "#{HACKER_NEWS_ROOT}/topstories.json")
		end

		def item(id:)
			request(path: "#{HACKER_NEWS_ROOT}/item/#{id}.json")
		end

		def request(path:)
			uri = URI(path)
			response = Net::HTTP.get_response(uri)
			response.body if response.is_a?(Net::HTTPSuccess)
		end
	end
end