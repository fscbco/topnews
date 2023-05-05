class AddSchemaFeed < ActiveRecord::Migration[7.0]
  def change
    ActiveRecord::Base.connection.create_schema('feed')
  end
end
