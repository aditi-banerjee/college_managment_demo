class AddResultToApplyAdmission < ActiveRecord::Migration[5.0]
  def change
    add_column :apply_admissions, :result, :string
  end
end
