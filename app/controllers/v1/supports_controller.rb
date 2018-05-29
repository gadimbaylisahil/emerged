module V1
  class SupportsController < V1::ApplicationController
    before_action :authenticate_with_token

    def index
      if params[:type] == 'received'
        supports = current_user.received_supports
      elsif params[:type] == 'given'
        supports = current_user.given_supports
      else
        supports = current_user.received_supports.or(current_user.given_supports)
      end
      render json: SupportSerializer.new(supports).serialized_json, status: :ok
    end

    def show
      support = find_support
      render json: SupportSerializer.new(support).serialized_json, status: :ok
    end

    def create
      supportable = find_supportable
      amount_cents = params[:amount_cents] || supportable.amount_cents
      support = supportable.supports.create!(amount_cents: amount_cents,
                                             supporter: current_user,
                                             creator: supportable.user,
                                             support_type: params[:support_type])
      render json: SupportSerializer.new(support, include_resources(%w[supporter creator])).serialized_json, status: :created
    end

    private

    def find_support
      Support.find_by!(id: params[:id])
    end

    # Currently supportable is only Reward but
    # will be extended into groups, projects, creations in the future.
    # TODO: add polymorphic finder instead of if/else confitions on which param exists
    def find_supportable
       Reward.find_by!(id: params[:reward_id])
    end
  end
end