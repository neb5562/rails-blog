class Notification < ApplicationRecord
  belongs_to :to_user, class_name: 'User', foreign_key: 'to'
  belongs_to :from_user, class_name: 'User', foreign_key: 'from'
  has_one :comment, required: false
  has_one :post, required: false
  has_one :request, required: false
  scope :all_except, ->(user) { where.not(from: user) }
end

