class AddUserFavoriteTable < ActiveRecord::Migration[7.0]
  def up
    create_table :user_favorites do |t|

      t.timestamps
    end
    add_reference :user_favorites, :user, foreign_key: true
    add_reference :user_favorites, :headline, foreign_key: true
  end

  def down
    drop_table :user_favorites
  end
end
