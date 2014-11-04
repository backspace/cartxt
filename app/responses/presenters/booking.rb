module Responses
  module Presenters
    class Booking < Liquid::Drop
      def initialize(booking)
        @booking = booking
      end

      def formatted
        Formatters::Booking.new(@booking).format
      end
    end
  end
end
