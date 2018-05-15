module V1
  class CartItemsController < V1::ApplicationController
    before_action :authenticate_with_token

    def index
      cart = find_cart
      head(:not_found) unless cart
      cart_items = cart.cart_items
      render json: CartItemSerializer.new(cart_items).serialized_json, status: :ok
    end

    def create
      cart = find_cart || create_cart
      cart_item = find_cart_item(cart)
      update_or_create_cart_item(cart: cart, cart_item: cart_item)
      render json: CartItemSerializer.new(cart_item), status: :ok
    end

    def update
      cart = find_cart
      cart_item = find_cart_item(cart)
      cart_item.update(quantity: params[:quantity])
    end

    def destroy
      cart = find_cart
      cart_item = find_cart_item(cart)
      cart_item.destroy!
      check_or_destroy_cart(cart)
      head(:ok)
    end

    private

    def cart_item_params
      params.permit(:quantity, :reward_id)
    end

    def find_cart
      current_user.carts.last
    end

    def find_cart_item(cart)
      cart.cart_items.where(reward_id: params[:reward_id])
    end

    def create_cart
      current_user.carts.create!
    end

    def check_or_destroy_cart(cart)
      return if cart.cart_items.any?
      cart.destroy!
      head(:ok)
    end

    def update_or_create_cart_item(cart:, cart_item:)
      if cart_item
        cart_item.update!(quantity: params[:quantity])
      else
        cart.cart_items.create!(quantity: params[:quantity], reward_id: params[:reward_id])
      end
    end
  end
end