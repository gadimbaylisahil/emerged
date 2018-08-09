class NotificationPolicy < ApplicationPolicy

  def get_related_resources?
    user == record
  end

  def show_relationship?
    user == record
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
