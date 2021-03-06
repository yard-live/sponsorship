class WebhooksController < ApplicationController
  # disable CSRF
  skip_before_action :verify_authenticity_token
  def create
    # receive exterenal requests
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    endpoint_secret = Rails.application.credentials.stripe[:webhook_secret]

    event = begin
              Stripe::Webhook.construct_event(
                payload, sig_header, endpoint_secret
              )
            rescue JSON::ParserError, Stripe::SignatureVerificationError => e
              render json: {message: e}, status: 400
              return
            end

    # Handle the event
    case event.type
    when 'payment_intent.succeeded'
      payment_intent = event.data.object # contains a Stripe::PaymentIntent
      puts 'PaymentIntent was successful!'
    when 'payment_method.attached'
      payment_method = event.data.object # contains a Stripe::PaymentMethod
      puts 'PaymentMethod was attached to a Customer!'
    # ... handle other event types
    else
      puts "Unhandled event type: #{event.type}"
    end

      render json: {message: 'Success'}
    end
end
