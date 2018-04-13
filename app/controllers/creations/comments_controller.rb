class Creations::CommentsController < CommentsController
  before_action :set_commentable

  private

  def set_commentable
    @commentable = Creation.find(params[:creation_id] || params[:id])
  end
end