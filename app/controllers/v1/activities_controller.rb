module V1
  class ActivitiesController < ApplicationController
    def index
      @activities = current_user.recent_activities(20)
    end
  end
end