class CreateTagcards < ActiveRecord::Migration
  def change
    create_table :tagcards do |t|
      t.integer :user_id
      t.integer :bcard_id
      t.integer :tags, array: true, default: []
      t.timestamps null: false
    end
  end
end
