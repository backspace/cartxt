module Responses
  module Presenters
    class BookingArray < SimpleDelegator
      def initialize(bookings)
        super(bookings.map{|booking| Responses::Presenters::Booking.new(booking)})
      end
    end
  end
end
