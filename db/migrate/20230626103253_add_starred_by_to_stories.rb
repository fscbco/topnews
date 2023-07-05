class AddStarredByToStories < ActiveRecord::Migration[7.0]
  def change
    add_column :stories, :starred_by, :integer
  end
end
