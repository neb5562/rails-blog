class Notification < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'to'
  has_one :comment, required: false
  has_one :post, required: false
end

