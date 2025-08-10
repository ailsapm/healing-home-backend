class Purchase < ApplicationRecord
  #associations
  belongs_to :user
  belongs_to :course

  #validations
  #price_paid must be present and a number ≥ 0
  validates :price_paid, numericality: { greater_than_or_equal_to: 0 }, presence: true
  validates :purchased_at, :payment_provider, presence: true
end
