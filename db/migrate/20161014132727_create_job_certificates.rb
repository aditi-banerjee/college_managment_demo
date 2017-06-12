class CreateJobCertificates < ActiveRecord::Migration[5.0]
  def change
    create_table :job_certificates do |t|
      t.integer :apply_job_id,           index: true
      t.string :title,                   limit: 50
      t.attachment :certificate

      t.timestamps
    end
  end
end
