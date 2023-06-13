require 'singleton'

class HackerNewsService

  include HTTParty
  include Singleton

  base_uri 'https://hacker-news.firebaseio.com/v0'

  def new_stories
    stories('/newstories.json')
  end

  def top_stories
    stories('/topstories.json')
  end

  def best_stories
    stories('/beststories.json')
  end

  def stories(path)
    response = self.class.get(path)
    if response.success?
      JSON.parse(response.body)[0..100]
    else
      # This would be a great place for some logging
      []
    end
  end


  def get_story(id)
    url = "/item/#{id}.json"

    # The extra layer of caching is somewhat redundant now, but
    # I did the cache logic here before I did the model and it
    # doesn't hurt to have some extra caching on network calls
    Rails.cache.fetch(["story-#{id}"], :expires => 1.day) do
      response = self.class.get(url)
      if response.success?
        JSON.parse(response.body).deep_symbolize_keys!
      else
        # This would be a great place for some logging
        nil
      end
    end
  end

  def get_updated_stories
    response = self.class.get('/updates.json')
    if response.success?
      response.body.items.each do |id|
        Rails.cache.delete([:story_json, id])
      end
    else
      # This would be another great place for some logs
      nil
    end
  end

end
