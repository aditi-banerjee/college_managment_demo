class CreateCollageImages < ActiveRecord::Migration[5.0]
  def change
    create_table :collage_images do |t|
      t.attachment :image

      t.timestamps
    end
  end
end
