class TradeFee < ApplicationRecord

  #
  # Associations
  #
  belongs_to(
    :trade
  )

  belongs_to(
    :fee
  )

  has_many(
    :registrations
    )

  #
  #Validations
  #
  validates(
    :trade_id,
    presence: true
  )

  validates(
    :fee_id,
    presence: true
  )
end
