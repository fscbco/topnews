class Story < ApplicationRecord
  has_many :users

  def hr_news_story
    hr_news = HackerRankNews.new(
      story_id: self.id,
      title: self.title,
      by: self.by,
      text: self.text,
      url: self.url,
      score: self.score,
      time: self.time
    )
    hr_news.get_story(story_id: self.id)
  end

end
