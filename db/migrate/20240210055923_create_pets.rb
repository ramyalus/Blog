class CreatePets < ActiveRecord::Migration[6.1]
  def change
    create_table :pets do |t|
      t.string :type, null: false
      t.string :name
      t.string :breed
      t.string :gender
      t.timestamps
    end
  end
end
