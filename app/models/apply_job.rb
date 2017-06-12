class ApplyJob < ApplicationRecord
  after_save :application_accepted

  #
  #Associations
  #
  belongs_to(
    :user
  )

  belongs_to(
    :trade
  )

  has_many(
    :job_certificates
  )

  has_attached_file :document
  validates_attachment :document,
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

  accepts_nested_attributes_for :job_certificates

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
    def application_accepted
      if(self.approve == true && !self.approve_by.nil?)
        faculty = Faculty.new
        faculty.attributes = {
          user_id:                    self.user_id,
          first_name:                 self.first_name,
          last_name:                  self.last_name,
          gender:                     self.gender,
          trade_id:                   self.trade_id,
          date_of_birth:              self.date_of_birth,
          address:                    self.address,
          mobile_no:                  self.contact_number,
          email:                      self.email
        }
        faculty.save!
        user_role = User.find(self.user_id)
          if !user_role.blank?
            user_role.update(access_role: "faculty")
          end
      elsif (self.approve == false && !self.approve_by.nil?)
        faculty = Faculty.find_by_user_id(self.user_id)
        if !faculty.blank?
          faculty.destroy
        end
      end
    end
end
