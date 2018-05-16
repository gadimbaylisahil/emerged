module V1
  class ReceivedOrdersController < V1::ApplicationController
    before_action :authenticate_with_token

    def index
      orders = current_user.split_purchases
      render json: SplitPurchaseSerializer.new(orders).serialized_json, status: :ok
    end

    def show
      order = find_received_order
      render json: SplitPurchaseSerializer.new(order).serialized_json, status: :ok
    end

    def update
      order = find_received_order
      order.update!(fullfillment_status: params[:fullfillment_status])
      render json: SplitPurchaseSerializer.new(order).serialized_json, status: :updated
    end

    private

    def find_received_order
      current_user.split_purchases.find_by!(id: params[:id])
    end
  end
end