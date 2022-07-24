class Subscription < ApplicationRecord
  belongs_to :user
  has_many :payments

  validate :check_timestamp

  def check_timestamp    
    last_subscription = Subscription.last
    last_payment = Payment.where(subscription_id: last_subscription.id).last
    if Subscription.last.end_at < Time.now && last_payment.status == true
       errors.add(:date, 'Your premium is still active')
    end
  end 

end
