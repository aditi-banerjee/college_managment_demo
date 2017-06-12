class CreateTrades < ActiveRecord::Migration[5.0]
  def change
    create_table :trades do |t|
      t.string :name
      t.integer :trade_duration
      t.boolean :disable,            default: false

      t.timestamps
    end
  end
end
