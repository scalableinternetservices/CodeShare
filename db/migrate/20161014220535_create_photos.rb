class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.string :image_uid
      t.string :title		
      t.timestamps null: false
    end
  end
end
