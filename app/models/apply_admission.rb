class ApplyAdmission < ApplicationRecord

  searchable auto_index: false do
    text :address
  end

  before_save(
    :image_size_validation,
    :image_extension_validation,
    :document_size_validation,
    :document_type_validation
  )

  after_save :admission_done

  #
  #Associations
  #
  belongs_to(
    :user
  )

  belongs_to(
    :trade
  )

  mount_uploader :result, ResultUploader
  has_attached_file :image,
                    styles: {
                              medium: "150x150>",
                              thumb:  "100x100>"
                            }
  validates_attachment  :image,
                        content_type:{
                          content_type: [
                                          "image/jpeg",
                                          "image/jpg",
                                          "image/png",
                                          "image/gif"
                                        ]
                        }
  has_attached_file :student_certificate
  validates_attachment :student_certificate,
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
  #
  #Validations
  #
  validates(
    :first_name,
    presence: true
  )

  validates(
    :last_name,
    presence: true
  )

  validates(
    :date_of_birth,
    presence: true
  )

  validates(
    :contact_number,
    presence: true
  )

  validates(
    :gender,
    presence: true
  )

  validates(
    :address,
    presence: true
  )

  private
    def image_size_validation
      if image.blank?
        errors[:image] << "Image Must be present."
      else
        errors[:image] << "Size must be less then 3MB" if image.size >= 1.megabytes
      end
    end

    def image_extension_validation
      %w(jpg jpeg gif png)
    end

    def document_size_validation
      if result.blank?
        errors[:document] << "Document Must present."
      else
        errors[:document] << "Size must be less then 5MB" if result.size > 5.megabytes
      end
    end

    def document_type_validation
      %w(jpg jpeg gif png application/doc application/pdf)
    end

    def admission_done
      if(self.approve == true && !self.approve_by.nil?)
        student = Student.new
        student.attributes = {
          user_id:                    self.user_id,
          first_name:                 self.first_name,
          last_name:                  self.last_name,
          gender:                     self.gender,
          trade_id:                   self.trade_id,
          date_of_birth:              self.date_of_birth,
          address:                    self.address,
          mobile_no:                  self.contact_number,
          email:                      self.email,
          image:                      self.try(:image)
        }
        student.save!
        user_role = User.find(self.user_id)
          if !user_role.blank?
            user_role.update(access_role: "student")
          end
      elsif (self.approve == false && !self.approve_by.nil?)
        student = Student.find_by_user_id(self.user_id)
        if !student.blank?
          student.destroy
        end
      end
    end
end
