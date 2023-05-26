class Story < ApplicationRecord

	def like(user_id:)
#		Like.new(user_id: user_id, story_id: hn_id)
	end

	class << self
		def ingest
			ids = JSON.parse(HackerNews.top_stories)[0..10]
			ids.each do |id|
				unless Story.exists?(hn_id: id)
					item = JSON.parse(HackerNews.item(id: id))
					story = Story.create(item.transform_keys{ |key| "hn_#{key}" })
				end
			end
		end
	end
end