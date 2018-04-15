class SessionsController < Clearance::SessionsController
  layout :set_layout

  protected

  def set_layout
    'session_and_registration'
  end

  def url_after_create
    discovery_creations_path
  end
end
