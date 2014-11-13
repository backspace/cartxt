class CarsController < ApplicationController
  before_filter :require_admin

  def index
    @cars = Car.all
  end

  def update
    @car = Car.find(params[:id])
    @car.update!(car_params)
    redirect_to cars_path
  end

  private
  def car_params
    params.require(:car).permit(:description, :location_information, :lockbox_information)
  end
end
