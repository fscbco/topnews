class AddUniqueIndexToHackerNewsRecommendations < ActiveRecord::Migration[7.0]
  def change
    add_index :hacker_news_recommendations, [:user_id, :hacker_news_story_id], unique: true, name: 'index_one_recommendation_per_user_and_story'
  end
end
