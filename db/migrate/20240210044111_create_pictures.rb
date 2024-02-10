class CreatePictures < ActiveRecord::Migration[6.1]
  def change
    create_table :pictures do |t|
    	t.string :image_url
    	t.references :imageable, polymorphic: true, index: true
      # t.interger :imageable_id
      # t.string :imageable_type
      t.timestamps
    end
  end
end
