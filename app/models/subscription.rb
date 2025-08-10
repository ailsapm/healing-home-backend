class Subscription < ApplicationRecord
  belongs_to :user
    validates :status, presence: true
    validates :started_at, :expires_at, presence: true
end
