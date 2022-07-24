class Subscription < ApplicationRecord
  belongs_to :user
  has_many :payments
end
