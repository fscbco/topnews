class CreateHackerNewsRecommendations < ActiveRecord::Migration[7.0]
  def change
    create_table :hacker_news_recommendations do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.references :hacker_news_story, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
