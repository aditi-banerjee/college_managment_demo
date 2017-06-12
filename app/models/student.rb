class Student < ApplicationRecord
  #
  # Associations
  #
  belongs_to(
    :trade
  )

  belongs_to(
    :user
  )

  has_many(
    :faculties
  )

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

  has_attached_file :result
  validates_attachment :result,
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

  def to_hash
    return {
              id:                   self.id,
              name:                 self.first_name,
              last_name:            self.last_name,
              gender:               self.gender,
              date_of_birth:        self.date_of_birth,
              date_of_admission:    self.date_of_admission,
              mobile_number:        self.mobile_no,
              email:                self.email
            }
  end

  #maps
  # geocoded_by :address
  # after_validation :geocode

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
    :trade_id,
    presence: true
  )

  validates(
    :date_of_birth,
    presence: true
  )

  validates(
    :mobile_no,
    presence: true
  )

  validates(
    :gender,
    presence: true
  )

  validates(
    :email,
    presence: true,
    format: {
      with: Devise.email_regexp
    },
    length: { in: 5..255 }
  )

  validates(
    :user_id,
    presence: true
    # uniqueness: true
  )
end
