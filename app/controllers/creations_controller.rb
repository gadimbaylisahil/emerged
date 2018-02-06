class CreationsController < ApplicationController
  def creation_params
    params.require(:creation).permit(:user, :tag_list)
  end
end
