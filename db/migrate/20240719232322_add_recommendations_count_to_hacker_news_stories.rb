class AddRecommendationsCountToHackerNewsStories < ActiveRecord::Migration[7.0]
  def change
    add_column :hacker_news_stories, :recommendations_count, :integer, default: 0, null: false
  end
end
