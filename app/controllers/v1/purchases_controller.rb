module V1
  class PurchasesController < V1::ApplicationController
    before_action :authenticate_with_token
    def index
      purchases = current_user.purchases.where(status: 'completed')
      render json: PurchaseSerializer.new(purchases), status: :ok
    end

    def show
      purchase = find_purchase
      render json: PurchaseSerializer.new(purchase).serialized_json, status: :ok
    end

    def create
      cart = find_cart
      purchase = current_user.purchases.create!(cart: cart, status: 'pending')
      render json: PurchaseSerializer.new(purchase), status: :created
    end

    def destroy
      purchase = find_purchase
      if purchase.status.eql?('completed')
        render json: { message: 'Not allowed to delete a completed purchase' }, status: :unprocessable_entity
        return
      end
      purchase.destroy
      head(:no_content)
    end

    private

    def find_purchase
      current_user.purchases.find_by!(id: params[:id])
    end

    def find_cart
      current_user.carts.find_by!(id: params[:cart_id])
    end
  end
end