class CreateApplyJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :apply_jobs do |t|
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.string :email
      t.string :contact_number
      t.string :address
      t.integer :trade_id
      t.decimal :percentage
      t.string :qualification
      t.date :date_of_birth
      t.date :passing_year
      t.integer :user_id

      t.timestamps
    end
  end
end
