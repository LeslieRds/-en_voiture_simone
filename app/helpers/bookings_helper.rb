# app/helpers/bookings_helper.rb
module BookingsHelper
  def display_total_price(booking)
    bookings_duration_days = (booking.end_date - booking.start_date).to_i + 1
    (booking.car.price_per_day * bookings_duration_days).round
  end
end
