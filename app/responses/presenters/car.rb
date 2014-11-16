module Responses
  module Presenters
    class Car < Liquid::Drop
      delegate :returned?, :borrowed?, :description, :location_information, :lockbox_information, :odometer_reading, :upcoming_booking?, :upcoming_booking, :rate, to: :@car

      def initialize(car)
        @car = car
      end

      def next_booking
        Presenters::Booking.new(@car.next_booking)
      end

      def current_booking
        Presenters::Booking.new(@car.current_booking)
      end
    end
  end
end
