class ChangeStoryIdDataTypeInStories < ActiveRecord::Migration[7.0]
  def up
    def change
      change_column :stories, :story_id, :string
    end
  end
end
