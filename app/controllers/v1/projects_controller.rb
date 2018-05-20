module V1
  class ProjectsController < V1::ApplicationController
    before_action :authenticate_with_token

    def index
      projects = current_user.projects
      render json: ProjectSerializer.new(projects).serialized_json, status: :ok
    end

    def show
      project = find_project
      render json: ProjectSerializer.new(project).serialized_json, status: :ok
    end

    def create
      project = current_user.projects.create!(project_params)
      render json: ProjectSerializer.new(project).serialized_json, status: :created
    end

    def update
      project = current_user.projects.find_by!(id: params[:id])
      project.update!(project_params)
      head(:ok)
    end

    def destroy
      project = current_user.projects.find_by!(id: params[:id])
      project.destroy
      head(:no_content)
    end

    private

    def find_project
      Project.find_by!(id: params[:project_id])
    end

    def project_params
      params.permit(:title, :description, :content)
    end
  end
end