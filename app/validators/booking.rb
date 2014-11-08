module Validators
  class Booking
    def initialize(options)
      @car = options[:car]
      @booking = options[:booking]

      @conflict_finder = BookingConflictFinder.new(car: @car, proposed_booking: @booking)
    end

    def valid?
      !@conflict_finder.conflict?
    end

    def conflicting_booking
      @conflict_finder.conflicting_booking
    end
  end
end
