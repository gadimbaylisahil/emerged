module V1
  class PaymentsController < V1::ApplicationController
    def create
      support = find_support

    end

    private
    def find_support
      Support.find_by(id: params[:support_id])
    end

    def generate_billing_address
    end

    def generate_shipping_address
    end

    def find_payment_method
    end

    def submit_payment
    end
  end
end