class UserPolicy < ApplicationPolicy
  def update?
    user == record
  end

  def destroy?
    user == record
  end

  def show_relationship?
    user == record
  end
  
  def create_relationship?
    user == record
  end

  def update_relationship?
    user == record
  end
  
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
