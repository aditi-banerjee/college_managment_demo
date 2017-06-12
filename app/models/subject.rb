class Subject < ApplicationRecord
  #
  #Associations
  #
  belongs_to(
    :trade
  )
end
