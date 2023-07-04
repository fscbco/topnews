class RemoveFlaggedByFromStories < ActiveRecord::Migration[7.0]
  def change
    remove_column :stories, :flagged_by, :integer
  end
end
