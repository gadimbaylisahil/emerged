class CommentsController < ApplicationController
  before_action :authenticate_with_token
  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    @comment.save
    redirect_to @commentable, notice: 'Your comment was successfuly posted!'
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
