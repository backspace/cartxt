module Responses
  module Presenters
    class Booking < Liquid::Drop
      def initialize(booking)
        @booking = booking
      end

      def formatted
        Formatters::Booking.new(@booking).format
      end

      def relative_end_time
        Formatters::RelativeTime.new(@booking.ends_at).format
      end

      def relative_beginning_time
        Formatters::RelativeTime.new(@booking.begins_at).format
      end
    end
  end
end
