class ChargesController < ApplicationController
  before_action :authenticate_user!
  PRICES = {'1' => 999, '3' => 2499, '6' => 4999, '12' => 9999}
  def new
    @amount = PRICES['1']
  end

  def create_subscription
    error_page unless PRICES.key?(params[:month])
    price = PRICES[params[:month]]
    transaction_id = SecureRandom.urlsafe_base64

    gp = generate_payment(transaction_id, price, params[:month])

    @session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      customer_email: current_user.email,
      metadata: {transaction_id: transaction_id},
      line_items: [
        price_data: {
          product: 'prod_M6wcKdUbCstfYH',
          unit_amount: price,
          currency: 'usd',
        },
        quantity: 1,
      ],
      mode: 'payment',
      success_url: "#{request.protocol + request.host_with_port}/#{I18n.locale}/premium?success=1&session_id={CHECKOUT_SESSION_ID}",
      cancel_url: "#{request.protocol + request.host_with_port}/#{I18n.locale}/charges/new?success=0",
    })
    redirect_to charges_path + '/?session_id=' + @session.id
    
  rescue Stripe::CardError => e
    flash[:alert] = e.message
    return false
  end

  private

  def generate_payment(transaction_id, price, months_count)
    ActiveRecord::Base.transaction do
      subscription = Subscription.new(name: "Premium", price: nil, start_at: nil, end_at: nil, months: months_count)
      subscription.user = current_user
      subscription.save!
      payment = Payment.new(transaction_id: transaction_id, status: false, payment_type: "stripe")
      payment.subscription = subscription
      payment.user = current_user
      payment.save!
    rescue
      flash[:alert] = "Something went wrong"
      return false
    end
  end
end
