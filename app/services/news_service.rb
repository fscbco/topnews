# Recurrently reload news table with top news stories
class NewsService
  def self.fetch_and_reload_news
    puts "Running news service"
    news_ids = get_top_news
    flagged_news_ids = News.where.not(names: '{}').ids
    new_news_ids = news_ids - flagged_news_ids
    news_objects = new_news_ids.slice(0,20).map { |id| get_news_details(id) }
    reload(news_objects)
  end

  def self.get_top_news
    puts "Getting top news"
    url = URI.parse('https://hacker-news.firebaseio.com/v0/topstories.json')
    response = Net::HTTP.get_response(url)
    if response.code == '200'
      JSON.parse(response.body)
    else
      raise "Hacker News API returned an error: #{response.code} #{response.message}"
    end
  end

  def self.get_news_details(id)
    puts "Getting news details"
    url = URI.parse("https://hacker-news.firebaseio.com/v0/item/#{id}.json")
    response = Net::HTTP.get_response(url)
    if response.code == '200'
      JSON.parse(response.body)
    else
      raise "Hacker News API returned an error: #{response.code} #{response.message}"
    end
  end

  def self.reload(objects)
    puts "Reloading News Data"
    News.where(names: '{}').delete_all
    objects.each do |object|
      puts object['title']
      news = News.new(id: object['id'], title: object['title'], url: object['url'])
      news.save
    end
  end
end