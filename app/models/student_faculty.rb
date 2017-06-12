class StudentFaculty < ApplicationRecord

  #
  # Associations
  #
  belongs_to(
    :student
  )

  belongs_to(
    :faculty
  )

  #
  #Validations
  #
  validates(
    :student_id,
    presence: true
  )

  validates(
    :faculty_id,
    presence: true
  )
end
