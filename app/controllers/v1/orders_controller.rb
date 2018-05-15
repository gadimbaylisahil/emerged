module V1
  class OrdersController < V1::ApplicationController
    before_action :authenticate_with_token
    def show

    end

    def create

    end

    def index
    end

    private

    def find_cart
      current_user.carts.last
    end
  end
end