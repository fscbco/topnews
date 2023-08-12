class YcConnector
  include HTTParty
  include JSON

  def initialize type="top"
    @feed_type = feed_type(type)
  end

  def get_stories
    @item_ids ||= HTTParty.get("#{service_url}/#{@feed_type}.json")
  end

  def load_item item_id
    HTTParty.get("#{service_url}/item/#{item_id}.json").body
  end

  def build_feed
    item_ids = get_stories.first(10)
    @feed = item_ids.map {|item_id| JSON.parse(load_item(item_id))}
  end

  private

  def service_url
    "https://hacker-news.firebaseio.com/v0/"
  end

  def feed_type ftype
    case ftype
    when "top"
      "topstories"
    when "best"
      "beststories"
    else
      "newstories"
    end
  end

  def set_last_item_fetched item_id
    Redis.current.set("last_item_fetched", item_id)
  end

  def last_item_fetched
    @item ||= Redis.current.get("last_item_fetched")
  end
end

class YCConnectorError < StandardError
  def initialize(message)
    super(message)
  end
end