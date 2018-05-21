module V1
  class PaymentsController < V1::ApplicationController
    before_action :authenticate_with_token
    def create
      payment = current_user.payments.create!(payment_params)
      render json: PaymentSerializer.new(payment).serialized_json, status: :created
    end

    private

    def payment_params
      params.require(:payment).permit(:amount_cents, :support_id, :payment_method_id,
                                      billing_address:  [:street, :street_optional, :city,
                                                         :state, :postal_code, :country,
                                                         :first_name, :last_name],
                                      shipping_address: [:street, :street_optional, :city,
                                                         :state, :postal_code, :country,
                                                         :first_name, :last_name, :company])
    end
  end
end