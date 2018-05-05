class ApplicationController < ActionController::Base
  include Clearance::Controller
  include Notifications
  protect_from_forgery with: :exception
end
