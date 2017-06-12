class ExamSchedule < ApplicationRecord
  #
  #Associations
  #
  belongs_to(
    :trade
  )
end
