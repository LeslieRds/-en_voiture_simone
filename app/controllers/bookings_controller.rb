class BookingsController < ApplicationController
include BookingsHelper
  def create
    @car = Car.find(params[:car_id])
    @booking = @car.bookings.build(user: current_user)
    authorize @booking

    # Extrait directement les dates de début et de fin à partir des params
    # puisqu'ils ne sont pas autorisés directement par booking_params
    if params[:booking] && params[:booking][:start_date]
      start_date_str, end_date_str = params[:booking][:start_date].split(' to ')
      @booking.start_date = Date.parse(start_date_str)
      @booking.end_date = Date.parse(end_date_str)
    end

    if @booking.save
      redirect_to car_path(@car), notice: "Booking successfully requested !"
    else
      redirect_to car_path(@car), alert: "An error has occured with selected dates"
    end
  end

  def index
    @bookings = policy_scope(Booking)
    # Accepted and rejected bookings
  end

  private

  def booking_params
      params.require(:booking).permit(:start_date, :end_date)
  end

  def formatMyBooking(bookings)
    bookings.map do |booking|
      {
        details: booking,
        status: bookingStatusMessage(booking),
        total_price: booking ? getTotalPrice(booking) : 0
      }
    end
  end

  def formatMyCarsBooking(bookings)
    bookings.map do |booking|
      {
        details: booking,
        total_price: booking ? getTotalPrice(booking) : 0
      }
    end
  end


  def getTotalPrice(booking)
      # Return the total price of the booking
      bookings_duration_days = (booking.end_date - booking.start_date)
      (booking.car.price_per_day * (bookings_duration_days)).round
  end

  def bookingStatusMessage(booking)
    if booking.accepted
      { message: 'Accepté!', class: 'status-accepted' }
    elsif booking.accepted == false
      { message: 'Refusé', class: 'status-rejected' }
    else
      { message: 'En attente de validation...', class: 'status-pending' }
    end
  end
end
