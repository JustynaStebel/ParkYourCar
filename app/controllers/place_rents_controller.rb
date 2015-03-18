class PlaceRentsController < ApplicationController
before_action :require_login

  def index
    @place_rents = PlaceRent.all
  end

  def show
    @place_rent = PlaceRent.find(params[:id])
  end

  def new
    @place_rent = parking.place_rents.new
  end

  def create
    @place_rent = parking.place_rents.new(place_rent_params)
    if @place_rent.save
      redirect_to parkings_path, notice: "Place rented!"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def parking
    @parking ||= Parking.find(params[:parking_id])
  end

  def place_rent_params
    params.require(:place_rent).permit(:starts_at, :ends_at, :car_id)
  end
end
