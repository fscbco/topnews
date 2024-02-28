class Article < ApplicationRecord
    has_and_belongs_to_many :users

    def self.new_articles
        # get JSON
        result = Net::HTTP.get(URI.parse('https://hacker-news.firebaseio.com/v0/topstories.json'))
        # parse JSON
        json = JSON.parse(result)

        articles = json.first(20).map do |a| 
            article = Article.find_by(article_foreign_id: a) 
            unless article 
                # get and parse json for each article
                article_data = Net::HTTP.get(URI.parse("https://hacker-news.firebaseio.com/v0/item/#{a}.json"))
                article_data = JSON.parse(article_data).symbolize_keys
                # create article in db
                Article.create(
                    author: article_data[:by], 
                    article_foreign_id: a,
                    score: article_data[:score],
                    text: article_data[:text],
                    time: article_data[:time],
                    title: article_data[:title],
                    article_type: article_data[:type],
                    url: article_data[:url]
                )
            end
        end
        articles
    end
end
