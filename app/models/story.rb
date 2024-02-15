class Story < ApplicationRecord
  has_many :users

  def hr_news_story
    hr_news = HackerRankNewsService.new(
      story_id: self.id,
      title: self.title,
      by: self.by,
      text: self.text,
      url: self.url,
      score: self.score,
      time: self.time
    )
    hr_news.get_story(self.id)
  end

  def hn_news_url(url)
    return url unless url.nil?
    "https://news.ycombinator.com/item?id=#{hr_news_story}"
  end
end
