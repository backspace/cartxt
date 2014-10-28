class NextBookingFormatter
  def initialize(options)
    @car = options[:car]
  end

  def output
    next_booking = @car.next_booking

    if next_booking.present?
      "Note that it is booked as of #{next_booking.begins_at.strftime("%Y-%m-%e %l:%M%p")}. "
    else
      ""
    end
  end
end
