class CreateCollectImages < ActiveRecord::Migration[5.0]
  def change
    create_table :collect_images do |t|
      t.attachment :image

      t.timestamps
    end
  end
end
