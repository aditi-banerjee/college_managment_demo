class AddRejectApproveToApplyJob < ActiveRecord::Migration[5.0]
  def change
    add_column :apply_jobs, :approve, :boolean,         default: false
    add_column :apply_jobs, :approve_by, :integer
    add_column :apply_jobs, :rejected_by, :integer
    add_column :apply_jobs, :reject, :boolean,          default: false
  end
end
