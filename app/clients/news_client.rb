require 'httparty'

class NewsClient
  include HTTParty
  format :json
  base_uri 'https://hacker-news.firebaseio.com/v0'

  def initialize()
  end

  def news_update
    response = self.class.get('/topstories.json')
    ids = JSON.parse(response.body)

    case response.code
    when 200
      ids.each do |id|
        next if Item.find_by(item_id: id)
        item = news_item(id)
        create_item(item)
      end
    else
      raise StandardError, "#{self.class.name}: #{response.error}"
    end
  end

  def news_item(id)
    response = self.class.get("/item/#{id}.json")

    case response.code
    when 200
      JSON.parse(response.body)
    else
      raise StandardError, "#{self.class.name}: #{response.error}"
    end
  end

  def create_item(data)
    new_item = Item.new do |i|
      i.item_id = data['id'].to_i
      i.by = data['by']
      i.title = data['title']
      i.item_type = data['type']
      url = data['url']
      i.url = url ? url : "https://news.ycombinator.com/item?id=#{i.item_id}"
      i.item_created_at = Time.at(data['time']).to_datetime
    end

    new_item.save
  end
end