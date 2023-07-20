module Hackerrank
    class Client
        require "uri"
        require "net/http"

        NUM_OF_ARTICLES_TO_SYNC = 30


        def call
            find_top_stories
        end

        def find_top_stories
            response = client("https://hacker-news.firebaseio.com/v0/topstories.json")

            array_of_stories = response.read_body.delete("]").delete("[").split(",").first(NUM_OF_ARTICLES_TO_SYNC)
            array_of_stories.each do |external_id|
                query_headlines(external_id)
            end
        rescue => e
            puts "Error encountered in find_top_stories method #{e}"
        end

        def query_headlines(external_id)
            # check db to see if we already have this story before saving
            matching_story = Headline.where(external_id: external_id)
            return unless matching_story.empty?

            response = client("https://hacker-news.firebaseio.com/v0/item/#{external_id}.json")
            json_payload = JSON.parse(response.body)

            return if external_id != json_payload["id"].to_s

            new_headline = Headline.new(
                external_id: json_payload["id"],
                title: json_payload["title"],
                url: json_payload["url"],
            )

            if new_headline.valid?
                new_headline.save!
            else
                puts "New Headline object is not valid #{x.errors.full_messages}"
            end
        rescue => e
            puts "Error encountered in query_headlines method #{e}"
        end

        def client(url)
            url = URI(url)
            https = Net::HTTP.new(url.host, url.port)
            https.use_ssl = true
            request = Net::HTTP::Get.new(url)
            response = https.request(request)
            return response
        end
    end
end