module V1
  class CartsController < V1::ApplicationController
    before_action :authenticate_with_token

    def show
      cart = find_cart
      render json: CartSerializer.new(cart, include_resources(%w[cart_items])).serialized_json, status: :ok
    end

    def destroy
      cart = find_cart
      cart.destroy
      head(:no_content)
    end

    private

    def find_cart
      current_user.carts.find_by!(status: 'active')
    end
  end
end