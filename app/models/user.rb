class User < ApplicationRecord
  enum access_role: [:admin, :faculty, :student, :user]

  #
  #Associations
  #
  has_many(
    :students
  )

  # has_many(
  #   :upload_fee_structures
  # )

  has_many(
    :faculties
  )

  has_many(
    :apply_admissions
  )

  accepts_nested_attributes_for(
    :students,
    :faculties
  )

  devise(
    :database_authenticatable,
    :registerable,
    :recoverable,
    :rememberable,
    :trackable,
    :validatable,
    :omniauthable
  )

  #
  #Validations
  #
  validates(
    :email,
    presence: true,
    format: {
      with: Devise.email_regexp
    },
    length: { in: 5..255 },
    uniqueness: true
  )

#
#Social Sign_UP
#
def self.connect_to_social_medium(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:provider => access_token.provider, :uid => access_token.uid ).first
    if user
      return user
    else
      registered_user = User.where(:email => access_token.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(
          provider:access_token.provider,
          email: data["email"],
          uid: access_token.uid ,
          password: Devise.friendly_token[0,20],
          access_role: "user"
        )
      end
    end
  end
end
