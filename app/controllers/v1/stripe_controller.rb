module V1
  class StripeController < ApplicationController
    def charge
      charge_customer if paid_before?(supporter)
      charge_details = {
          stripe_token: params[:stripe_token],
          amount_cents: params[:amount_cents],
          currency: params[:currency],
          connected_stripe_account_id: extract_stripe_id,
      }
      charge = StripeCharger.new(charge_details).charge
      render json: charge, status: :created
      # Deal with response afterwards
    end

    def subscribe
    end

    private

    def charge_customer

    end

    def extract_stripe_id
      creator = User.find_by!(id: params[:creator_id])
      creator.stripe_account_id
    end

    def paid_before(supporter_id)
      supporter = User.find_by!(id: supporter_id)
      supporter.stripe_customer_id.present?
    end
  end
end