class CreateDecks < ActiveRecord::Migration
  def change
    create_table :decks do |t|
      t.integer :user_id
      t.text :business_cards
      t.string :description

      t.timestamps null: false
    end
  end
end
