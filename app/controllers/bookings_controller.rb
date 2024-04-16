class BookingsController < ApplicationController
  include BookingsHelper
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  def show
    authorize @booking
  end

  def create
    @car = Car.find(params[:car_id])
    @booking = @car.bookings.build(user: current_user)
    authorize @booking

    start_date_str, end_date_str = params[:booking][:start_date].split(' to ')
    @booking.start_date = Date.parse(start_date_str)
    @booking.end_date = Date.parse(end_date_str)

    if @booking.save
      redirect_to car_path(@car), notice: "Booking successfully requested!"
    else
      redirect_to car_path(@car), alert: "An error has occurred with selected dates"
    end
  end

  def index
    @bookings = if current_user.admin?
                  policy_scope(Booking.all)
                else
                  policy_scope(Booking).where(user: current_user)
                end
    skip_policy_scope if current_user.admin?
  end

  def destroy
    authorize @booking
    if @booking.destroy
      redirect_to bookings_path, notice: 'La réservation a été supprimée avec succès.'
    else
      redirect_to bookings_path, alert: 'Un problème est survenu lors de la suppression de la réservation.'
    end
  end

  private

  def set_booking
    @booking = Booking.find_by(id: params[:id])
    redirect_to root_path, alert: "Réservation introuvable." unless @booking
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end

  def getTotalPrice(booking)
    bookings_duration_days = (booking.end_date - booking.start_date).to_i + 1
    (booking.car.price_per_day * bookings_duration_days).round
  end
end
