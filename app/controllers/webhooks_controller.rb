class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    event = nil

    begin
    event = Stripe::Webhook.construct_event(
      payload, sig_header, "whsec_YqPTWpmBeWCtJxMEQU88dq4rAVUmlb2c"
    )
    rescue JSON::ParserError => e
      status 400
    return
    rescue Stripe::SignatureVerificationError => e
      # Invalid signature
      puts "Signature error"
      p e
      return
    end

    # Handle the event
    case event.type
    when 'checkout.session.completed'
      session = event.data.object
      payment = Payment.find_by(transaction_id: session.metadata.transaction_id)
      subscription = payment.subscription
      subscription.start_at = Time.now
      subscription.end_at = Time.now + subscription.months.to_i.months
      payment.status = true
      payment.save!
      subscription.save!
    end

    render json: { message: 'success' }
  end
end 