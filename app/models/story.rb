class Story < ApplicationRecord
  has_many :users

  def hr_news_story
    hr_news = HackerRankNewsService.new
    hr_news.get_story(self.id)
  end
end