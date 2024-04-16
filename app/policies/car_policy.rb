class CarPolicy < ApplicationPolicy
  #Tous les utilisateurs peuvent voir les voitures
  def index?
    true
  end

  def show?
    true
  end

  #Seul l'admin peut créer, modifier et supprimer
  def create?
    user.present? && user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end
end
