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

  def build_feed(page:)
    item_ids = get_stories[((10 * page) - 10)...10 * page]
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
end
