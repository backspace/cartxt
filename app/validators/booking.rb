module Validators
  class Booking
    def initialize(options)
      @car = options[:car]
      @booking = options[:booking]

      @conflict_finder = BookingConflictFinder.new(car: @car, proposed_booking: @booking)

      valid?
    end

    def valid?
      @reason = nil

      @reason = :past if booking_in_past
      @reason = :conflict if @conflict_finder.conflict?

      @reason == nil
    end

    def conflict?
      @reason == :conflict
    end

    def past?
      @reason == :past
    end

    def conflicting_booking
      @conflict_finder.conflicting_booking
    end

    def booking
      @booking
    end

    private
    def booking_in_past
      @booking.begins_at < Time.now || @booking.ends_at < Time.now
    end
  end
end
