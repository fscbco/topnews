class UpdateNewsStoryType < ActiveRecord::Migration[7.0]
  def change
    remove_column :news_stories, :type, :string
    add_column :news_stories, :story_type, :string
  end
end
