class StripeCharger

  def initialize(charge_details = {})
    @amount_cents = charge_details[:amount_cents]
    @currency = charge_details[:currency]
    @connected_stripe_account_id = charge_details[:connected_stripe_account_id]
    @stripe_token = charge_details[:card_token] || 'tok_visa'
  end

  def charge
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    Stripe::Charge.create({ amount: @amount_cents,
                                            currency: @currency,
                                            source: @stripe_token,
                                            application_fee: calculate_application_fee
                                          }, stripe_account: "#{@connected_stripe_account_id}")
  end

  private

  def calculate_application_fee
    (@amount_cents * 5) / 100
  end
end

# {
#     "id": "ch_1CXxpcIfRDaoT49NGWBLmq3v",
#     "object": "charge",
#     "amount": 1000,
#     "amount_refunded": 0,
#     "application": "ca_CxAOwa0D8QGuoUOKuiZpiWuuudl4JJZZ",
#     "application_fee": "fee_1CXxpcIfRDaoT49NQsKNikP7",
#     "balance_transaction": "txn_1CXxpcIfRDaoT49Ns3IAujtZ",
#     "captured": true,
#     "created": 1527800232,
#     "currency": "eur",
#     "customer": null,
#     "description": null,
#     "destination": null,
#     "dispute": null,
#     "failure_code": null,
#     "failure_message": null,
#     "fraud_details": {},
#     "invoice": null,
#     "livemode": false,
#     "metadata": {},
#     "on_behalf_of": null,
#     "order": null,
#     "outcome": {
#         "network_status": "approved_by_network",
#         "reason": null,
#         "risk_level": "normal",
#         "seller_message": "Payment complete.",
#         "type": "authorized"
#     },
#     "paid": true,
#     "receipt_email": null,
#     "receipt_number": null,
#     "refunded": false,
#     "refunds": {
#         "object": "list",
#         "data": [],
#         "has_more": false,
#         "total_count": 0,
#         "url": "/v1/charges/ch_1CXxpcIfRDaoT49NGWBLmq3v/refunds"
#     },
#     "review": null,
#     "shipping": null,
#     "source": {
#         "id": "card_1CXxpcIfRDaoT49NK4uDdEQJ",
#         "object": "card",
#         "address_city": null,
#         "address_country": null,
#         "address_line1": null,
#         "address_line1_check": null,
#         "address_line2": null,
#         "address_state": null,
#         "address_zip": null,
#         "address_zip_check": null,
#         "brand": "Visa",
#         "country": "US",
#         "customer": null,
#         "cvc_check": null,
#         "dynamic_last4": null,
#         "exp_month": 5,
#         "exp_year": 2019,
#         "fingerprint": "AO9cDCXmXkAFsy0d",
#         "funding": "credit",
#         "last4": "4242",
#         "metadata": {},
#         "name": null,
#         "tokenization_method": null
#     },
#     "source_transfer": null,
#     "statement_descriptor": null,
#     "status": "succeeded",
#     "transfer_group": null
# }