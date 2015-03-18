class CarsController < ApplicationController
before_action :car_find, only: [:show,:edit, :destroy]
before_action :require_login

  def index
    if current_person
      @cars = current_person.cars
    else
      flash[:danger] = "Please log in!"
      redirect_to new_session_path
    end
  end

  def show
  end

  def new
    @car = current_person.cars.build
  end

  def create
    @car = current_person.cars.build(car_params)

    if @car.save
      redirect_to @car
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @car = current_person.cars.find(params[:id])

    if @car.update(car_params)
      redirect_to @car
    else
      render 'edit'
    end
  end

  def destroy
    @car.destroy

    redirect_to @car
  end

  private

  def car_params
    params.require(:car).permit(:model, :registration_number)
  end

  def car_find
    @car = current_person.cars.find(params[:id])
    rescue ActiveRecord::RecordNotFound
    flash[:error] = "Car doesn't exist!"
    redirect_to cars_path
  end
end
