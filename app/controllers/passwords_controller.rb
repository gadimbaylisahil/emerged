class PasswordsController < Clearance::PasswordsController
  layout :set_layout

  private
  def set_layout
    'application'
  end
end
