module V1
  class CartsController < V1::ApplicationController
    before_action :authenticate_with_token

    def show
      cart = find_cart
      render json: CartSerializer.new(cart).serialized_json, status: :ok
    end

    def destroy
      cart = find_cart
      cart.destroy!
      head(:ok)
    end

    private

    def find_cart
      current_user.carts.last
    end
  end
end