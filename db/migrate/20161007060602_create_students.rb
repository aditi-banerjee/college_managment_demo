class CreateStudents < ActiveRecord::Migration[5.0]
  def change
    create_table :students do |t|
      t.string  :first_name
      t.string  :last_name
      t.string  :gender,             limit:1
      t.date    :date_of_birth
      t.date    :date_of_admission
      t.integer :trade_id
      t.integer :user_id
      t.string  :address
      t.string  :mobile_no,           limit: 15
      t.boolean :disable,            default: false
      t.string  :email

      t.timestamps
    end
    add_index  :students,            :trade_id
    add_index  :students,            :user_id
  end
end
