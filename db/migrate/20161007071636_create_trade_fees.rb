class CreateTradeFees < ActiveRecord::Migration[5.0]
  def change
    create_table :trade_fees do |t|
      t.integer :trade_id
      t.integer :fee_id
      t.boolean :disable,            default: false

      t.timestamps
    end
  end
end
