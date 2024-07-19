namespace :refresh_articles do

  HN_TOP_STORIES_URL = "https://hacker-news.firebaseio.com/v0/topstories.json"

  desc "Populate"
  task fetch: :environment do
    # TODO: Use something fancier like Faraday
    resp = Net::HTTP.get_response(URI.parse(HN_TOP_STORIES_URL))
    body = resp.body
    stories = JSON.parse(body)
    stories.each { |id|
      next if Article.where(hn_id: id).any?
      story_url = "https://hacker-news.firebaseio.com/v0/item/#{id}.json"
      resp = Net::HTTP.get_response(URI.parse(story_url))
      body = resp.body
      details = JSON.parse(body)
      a = Article.new(hn_id: id, title: details["title"], author: details["author"], 
          hn_time: Time.at(details["time"]), hn_url: details["url"], hn_type: details["story"])
      a.save!
    }

  end

  desc "Delete old articles"
  task erase: :environment do
    # TODO: Make this configurable
    Article.where(hn_time: ..7.days.ago).delete_all
    # TODO: Save starred articles?
  end

end
