class Trade < ApplicationRecord

  searchable do
    text :name
  end

  #
  # Associations
  #
  has_many(
    :faculties
  )

  has_many(
    :students
  )

  has_many(
    :exam_schedules
  )

  has_many(
    :subjects
  )

  has_many(
    :fees
  )

  has_many(
    :apply_admissions
  )

  has_many(
      :apply_jobs
    )

  #
  #Validations
  #
  validates(
    :name,
    presence: true
  )

  validates(
    :trade_duration,
    presence: true
  )
end
