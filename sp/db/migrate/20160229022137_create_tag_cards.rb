class CreateTagCards < ActiveRecord::Migration
  def change
    create_table :tag_cards do |t|
      t.integer :user_id
      t.integer :tag_id
      t.integer :business_card_id

      t.timestamps null: false
    end
  end
end
