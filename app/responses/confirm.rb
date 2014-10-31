module Responses
  class Confirm < AbstractResponse
    def initialize(options)
      super
      @booking = options[:booking]
    end

    def body
      "You have booked me from #{@booking.begins_at.to_formatted_s} to #{@booking.ends_at.to_formatted_s}. #{afterspace_potential_content(@car.location_information)}When the time comes, send \"borrow\"."
    end
  end
end
