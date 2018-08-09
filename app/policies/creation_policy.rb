class CreationPolicy < ApplicationPolicy
  def update?
    user == record.user
  end

  def destroy?
    user == record.user
  end

  def create_relationship?
    user == record.user
  end
  
  def auth_destroy_relationship?
    user == record.user
  end

  def update_relationship?
    user == record.user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
