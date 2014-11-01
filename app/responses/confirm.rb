module Responses
  class Confirm < AbstractResponse
    def initialize(options)
      super
      @booking = options[:booking]
    end

    def body
      "You have booked me #{Formatters::Booking.new(@booking).format}. #{afterspace_potential_content(@car.location_information)}When the time comes, send \"borrow\"."
    end
  end
end
