class CarsController < ApplicationController
  def index
    @cars = policy_scope(Car)
  end

  def show
    @car = Car.find(params[:id])
    authorize @car
    @booking = Booking.new
  end

  def new
    @car = Car.new
    authorize @car
  end

  def create
    @car = Car.new(car_params)
    @car = current_user.cars.build(car_params) # Assurez-vous que current_user est bien défini
    authorize @car
    if @car.save
      redirect_to car_path(@car), notice: 'Car was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @car = Car.find(params[:id])
    authorize @car
  end

  def update
    @car = Car.find(params[:id])
    authorize @car
    if @car.update(car_params)
      redirect_to car_path(@car), notice: 'Car was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @car = Car.find(params[:id])
    authorize @car
    @car.destroy
    redirect_to cars_url, notice: 'Car was successfully destroyed.'
  end

  private
    def car_params
      params.require(:car).permit(:brand, :model, :year_of_production, :price_per_day, :description, :nb_passenger)
    end
end
