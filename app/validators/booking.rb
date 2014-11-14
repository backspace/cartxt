module Validators
  class Booking
    def initialize(options)
      @car = options[:car]
      @booking = options[:booking]

      @conflict_finder = BookingConflictFinder.new(car: @car, proposed_booking: @booking)

      # FIXME hackish
      @exception = options[:exception]

      valid?
    end

    def valid?
      @reason = nil

      @reason = :reversed if booking_reversed?
      @reason = :past if booking_in_past? && @exception != :past
      @reason = :conflict if @conflict_finder.conflict?

      @reason == nil
    end

    def conflict?
      @reason == :conflict
    end

    def past?
      @reason == :past
    end

    def reversed?
      @reason == :reversed
    end

    def conflicting_booking
      @conflict_finder.conflicting_booking
    end

    def booking
      @booking
    end

    private
    def booking_in_past?
      @booking.begins_at < Time.now || @booking.ends_at < Time.now
    end

    def booking_reversed?
      @booking.ends_at < @booking.begins_at
    end
  end
end
