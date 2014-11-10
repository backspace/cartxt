module Commands
  class Bookings < AbstractCommand
    def execute
      @responses.push Responses::Bookings.new(car: car, sharer: sharer, bookings: sharer.bookings.upcoming)
    end
  end
end
