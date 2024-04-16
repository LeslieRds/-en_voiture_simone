class BookingPolicy < ApplicationPolicy
 # Permettre à tous les utilisateurs de créer une réservation
  def create?
    user.present?
  end

  # Assurer que les utilisateurs ne peuvent voir que leurs propres réservations
  def show?
    user.admin? || record.user == user
  end


  def edit?
    user.admin? || record.user == user
  end
  # Autoriser l'accès uniquement à leurs propres réservations pour les modifications
  def update?
    user.admin? || record.user == user
  end

  # Autoriser la suppression uniquement de leurs propres réservations
  def destroy?
    user.admin? ||record.user == user
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user: user)
      end
    end
  end
end
