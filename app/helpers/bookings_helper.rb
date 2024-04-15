# app/helpers/bookings_helper.rb
module BookingsHelper
  def bookingStatusMessage(booking)
    if booking[:details]&.accepted
      { message: 'Accepté!', class: 'status-accepted' }
    elsif booking[:details]&.accepted == false
      { message: 'Refusé', class: 'status-rejected' }
    else
      { message: 'En attente de validation...', class: 'status-pending' }
    end
  end
end
