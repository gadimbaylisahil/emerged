# class StripeCustomerSaver
#   def initialize(customer:, stripe_token:)
#     @customer = customer
#     @stripe_token = stripe_token
#   end
#
#   def save
#     customer = Stripe::Customer.create(email: @customer.email,
#                                        source: @stripe_token)
#     @customer.stripe_customer_id = customer.id
#     @customer.save!
#   end
# end
# TODO: come to this after building frontend