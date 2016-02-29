class CreateBusinessCards < ActiveRecord::Migration
  def change
    create_table :business_cards do |t|
      t.text :addresses
      t.string :linkedin
      t.string :facebook
      t.string :twitter
      t.string :instagram
      t.string :pinterest
      t.string :first_name
      t.string :last_name

      t.timestamps null: false
    end
  end
end
