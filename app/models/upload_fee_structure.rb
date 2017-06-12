class UploadFeeStructure < ApplicationRecord
  attr_accessor  :upload_content_type

  # #
  # # Associations
  # #
  # belongs_to :user

  #
  # Validation
  #
  # validates(
  #   :user_id,
  #   presence: true
  # )

  has_attached_file(
    :upload,
    default_url: "/excel_upload/:id_partition/:filename"
  )

  validates_attachment_content_type(
    :upload,
    content_type: [
      'application/xls',
      'application/xlsx',
      'application/vnd.ms-excel',
      'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
      'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    ],
    message: 'Only EXCEL files are allowed.'
  )

  def get_processed_file_name
    old_path = self.upload.url
    new_path = old_path.split("/")
    new_path.pop()
    temp_old_file_name = File.basename(self.upload.original_filename, ".*")
    new_file = "#{temp_old_file_name}_completed_#{self.id}.xls"
    return "#{new_path.join("/")}/#{new_file}"
  end
end
