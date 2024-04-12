class CarsController < ApplicationController
  def index
    @cars = Car.all
  end

  def show
    @car = Car.find(params[:id])
    @booking = Booking.new
  end

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)
    @car.user = current_user # Assurez-vous que current_user est bien défini

    if @car.save
      redirect_to car_path(@car), notice: 'Car was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

    def my_cars
    @my_cars = Car.where(user: current_user)
  end

  private
    def car_params
      params.require(:car).permit(:brand, :model, :year_of_production, :price_per_day, :address)
    end
end
