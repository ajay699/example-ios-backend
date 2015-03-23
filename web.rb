require 'sinatra'
require 'stripe'
require 'dotenv'

Dotenv.load

Stripe.api_key = ENV['STRIPE_TEST_SECRET_KEY']

get '/' do
  status 200
  return "Great, your backend is set up. Now you can configure the Stripe example iOS apps to point here."
end

post '/charge' do

  # Get the credit card details submitted by the form
  token = params[:stripeToken]

  # Create the charge on Stripe's servers - this will charge the user's card
 recipient = Stripe::Recipient.create(
  :name => "John Doe",
  :type => "individual",
  :email => "payee@example.com",
:tax_id=>"000000000",
  :bank_account => token
)


transfer=Stripe::Transfer.create(
  :amount => 1000,
  :currency => "usd",
  :recipient => recipient.id,
  :description => "Transfer for test@example.com"
)

  status 200
  return "Order successfully created"

end
