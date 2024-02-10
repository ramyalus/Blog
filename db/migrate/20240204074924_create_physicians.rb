class CreatePhysicians < ActiveRecord::Migration[6.1]
  def change
    create_table :physicians do |t|
      t.string :name
      t.integer :age
      t.boolean :gender
      t.string :specialization
      t.string :hospital

      t.timestamps
    end
  end
end
