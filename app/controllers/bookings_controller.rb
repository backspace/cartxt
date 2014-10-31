class BookingsController < ApplicationController
  def index
    if params[:start].present?
      @bookings = Booking.overlapping(params[:start], params[:end])
    else
    end
  end
end
