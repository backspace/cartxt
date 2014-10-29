class BookingsController < ApplicationController
  def index
    if params[:start].present?
      @bookings = Booking.between(params[:start], params[:end])
    else
    end
  end
end
