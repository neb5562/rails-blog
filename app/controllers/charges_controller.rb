class ChargesController < ApplicationController
  before_action :authenticate_user!
  AMOUNT = 999

  def new
    @amount = AMOUNT
  end
  
  def create
  # Amount in cents
  
  customer = Stripe::Customer.create(
    :email => params[:stripeEmail],
    :source => params[:stripeToken]
  )
  
  charge = Stripe::Charge.create(
    :customer => customer.id,
    :amount => AMOUNT,
    :description => 'RocketApp Stripe customer',
    :currency => 'usd'
  )
  @amount = charge.amount_captured.to_f
  subscription = Subscription.new(name: "Premium", price: charge.amount_captured.to_f / 100, start_at: Time.now, end_at: Time.now + 1.month)
  subscription.user = current_user
  payment = Payment.new(transaction_id: charge.id, status: charge.paid, payment_type: "stripe")
  payment.subscription = subscription
  payment.user = current_user

  ActiveRecord::Base.transaction do
    subscription.save!
    payment.save!
  rescue
    # redirect to premium page
  end

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end
