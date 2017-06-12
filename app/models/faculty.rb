class Faculty < ApplicationRecord
  # scoped_search
  scoped_search on: [:first_name, :last_name, :address]

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
    :students
  )

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

  def hash_data
    return {
              id:                   self.id,
              user_id:              self.user_id,
              name:                 self.first_name,
              last_name:            self.last_name,
              gender:               self.gender,
              date_of_birth:        self.date_of_birth,
              date_of_admission:    self.date_of_join,
              mobile_number:        self.mobile_no,
              email:                self.email
            }
  end
end
