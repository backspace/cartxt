class BookingConflictFinder
  def initialize(options)
    @car = options[:car]
    @proposed_booking = options[:proposed_booking]

    find_conflicting_booking
  end

  def conflict?
    @conflict
  end

  def conflicting_booking
    @conflicting_booking
  end

  private
  def find_conflicting_booking
    conflicting_bookings = @car.bookings.overlapping(@proposed_booking.begins_at, @proposed_booking.ends_at)

    @conflict = conflicting_bookings.present?
    @conflicting_booking = conflicting_bookings.first
  end
end
