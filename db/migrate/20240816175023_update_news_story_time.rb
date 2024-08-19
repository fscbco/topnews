class UpdateNewsStoryTime < ActiveRecord::Migration[7.0]
  def change
    change_column :news_stories, :time, :bigint
  end
end
