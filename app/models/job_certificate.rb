class JobCertificate < ApplicationRecord
  belongs_to(
    :apply_job
  )

  has_attached_file :certificate
  validates_attachment :certificate,
                        content_type: {
                          content_type: [
                            "image/jpeg",
                            "image/jpg",
                            "image/png",
                            "application/pdf",
                            "application/msword",
                            "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
                          ]
                        }
end
