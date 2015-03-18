class ParkingsController < ApplicationController
before_action :parking_find, only: [:show,:edit, :destroy]

  def index
    @parkings = Parking.search(params)
  end

  def show
  end

  def new
    @parking = Parking.new
    @parking.build_address
  end

  def create
    @parking = Parking.new(parking_params)

    if @parking.save
      redirect_to @parking
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @parking = Parking.find(params[:id])

    if @parking.update(parking_params)
      redirect_to @parking
    else
      render 'edit'
    end
  end

  def destroy
    @parking.destroy

    redirect_to @parking
  end

  private

  def parking_params
    params.require(:parking).permit(:kind, :places, :hour_price, :day_price, :address_attributes => [:city, :street, :zip_code])
  end

  def parking_find
    @parking = Parking.find(params[:id])
    rescue ActiveRecord::RecordNotFound
    flash[:error] = "Parking doesn't exist!"
    redirect_to parkings_path
  end

end
