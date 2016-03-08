class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :text
      t.integer :hits
      t.integer :user_id
      t.integer :businesscard_id
      
      t.timestamps null: false
    end
  end
end
