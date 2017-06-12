class CreateUploadFeeStructures < ActiveRecord::Migration[5.0]
  def change
    create_table :upload_fee_structures do |t|
      t.string :upload_file_name
      t.string :status,             limit: 1
      t.integer :number_of_success
      t.integer :number_of_fail
      t.integer :total_record
      t.string :fail_error
    end
  end
end
