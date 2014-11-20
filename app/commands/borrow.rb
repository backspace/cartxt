module Commands
  class Borrow < AbstractCommand
    def initialize(options)
      super
    end

    def execute
      if car.may_borrow?
        booking = Booking.has_current_booking?(car: car, sharer: sharer)
        if booking.present?
          car.borrow!
          booking.begin!
          Borrowing.create(car: car, sharer: sharer, rate: car.rate, booking: booking)
          @responses.push Responses::Borrow.new(car: car, sharer: sharer, booking: booking)
        else
          @responses.push Responses::BorrowAdHoc.new(car: car, sharer: sharer)
        end
      else
        @responses.push Responses::BorrowFailure.new(car: car, sharer: sharer)
      end
    end
  end
end
