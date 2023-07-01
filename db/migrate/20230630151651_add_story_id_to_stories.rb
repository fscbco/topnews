class AddStoryIdToStories < ActiveRecord::Migration[7.0]
  def change
    add_column :stories, :story_id, :string
  end
end
