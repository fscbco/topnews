class CreateFlags < ActiveRecord::Migration[7.0]
  def change
    create_table :flags do |t|
      t.integer :story_id
      t.integer :user_id

      t.timestamps
    end
  end
end
