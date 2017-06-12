class AddImageToStudent < ActiveRecord::Migration[5.0]
  def change
    add_attachment :students, :image
    add_attachment :students, :result
  end
end
