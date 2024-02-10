class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :category_id
      t.integer :price
      t.boolean :cod 
      t.date :release_date
      t.timestamps
    end
  end
end
