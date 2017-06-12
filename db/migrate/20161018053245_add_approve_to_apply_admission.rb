class AddApproveToApplyAdmission < ActiveRecord::Migration[5.0]
  def change
    add_column :apply_admissions, :approve_by, :integer
    add_column :apply_admissions, :approve, :boolean,     default: false
  end
end
