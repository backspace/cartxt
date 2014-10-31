module Responses
  class Confirm < AbstractResponse
    def initialize(options)
      super
      @booking = options[:booking]
    end

    def body
      "You have booked the car from #{@booking.begins_at.to_formatted_s} to #{@booking.ends_at.to_formatted_s}.#{location} When the time comes, send \"borrow\"."
    end

    private
    # FIXME
    def location
      if @car.location_information.present?
        " #{@car.location_information}"
      else
        ""
      end
    end
  end
end
