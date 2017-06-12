class AddCertificatesToApplyAdmission < ActiveRecord::Migration[5.0]
  def change
    add_attachment :apply_admissions, :student_certificate
  end
end
