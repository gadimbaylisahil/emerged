module V1
  class SupportsController < V1::ApplicationController

    def index
      supports = current_user.supports
      render json: SupportSerializer.new(supports).serialized_json, status: :ok
    end

    def show
      support = find_support
      render json: SupportSerializer.new(support).serialized_json, status: :ok
    end

    def create
      supportable = find_supportable
      support = supportable.supports.create!(amount_cents: params[:amount_cents], user: current_user)
      render json: SupportSerializer.new(support).serialized_json, status: :created
    end

    private
    def find_supportable
      if params[:user_id]
        User.find_by!(id: params[:user_id])
      elsif params[:project_id]
        Project.find_by(id: params[:project_id])
      end
    end
  end
end