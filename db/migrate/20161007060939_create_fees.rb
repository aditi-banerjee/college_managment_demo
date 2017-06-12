class CreateFees < ActiveRecord::Migration[5.0]
  def change
    create_table :fees do |t|
      t.string :duration
      t.decimal :amount
      t.boolean :disable,            default: false

      t.timestamps
    end
  end
end
