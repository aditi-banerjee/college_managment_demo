class AddDocumentToApplyJob < ActiveRecord::Migration[5.0]
  def change
    add_attachment :apply_jobs, :document
  end
end
