class AddRejectToApplyAdmission < ActiveRecord::Migration[5.0]
  def change
    add_column :apply_admissions, :reject_by, :integer
    add_column :apply_admissions, :reject, :boolean,  default: false
  end
end
