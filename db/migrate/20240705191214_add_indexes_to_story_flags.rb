class AddIndexesToStoryFlags < ActiveRecord::Migration[7.0]
  def change
    add_index :stories, :deleted
    add_index :stories, :dead
  end
end
