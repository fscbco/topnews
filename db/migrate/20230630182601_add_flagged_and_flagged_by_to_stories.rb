class AddFlaggedAndFlaggedByToStories < ActiveRecord::Migration[7.0]
  def change
    add_column :stories, :flagged, :boolean
    add_column :stories, :flagged_by, :integer
  end
end
