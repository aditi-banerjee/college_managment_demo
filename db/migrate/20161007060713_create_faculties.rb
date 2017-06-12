class CreateFaculties < ActiveRecord::Migration[5.0]
  def change
    create_table :faculties do |t|
      t.string  :first_name
      t.string  :last_name
      t.date    :date_of_birth
      t.date    :date_of_join
      t.integer :trade_id
      t.integer :user_id
      t.string  :address
      t.decimal :salary
      t.string  :gender,              limit: 1
      t.string  :mobile_no,           limit: 15
      t.boolean :disable,            default: false
      t.string  :email

      t.timestamps
    end
    add_index :faculties,             :trade_id
  end
end
