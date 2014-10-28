describe Commands::Book do
  let(:sharer) { :sharer }
  let(:car) { :car }

  let(:booking_string) { :booking_string }

  # FIXME centralise time formatting?
  def format_time(time)
    time.strftime("%Y-%m-%e %l:%M%p")
  end

  it 'delegates to the booking parser and creates a booking' do
    book = Commands::Book.new(car: car, sharer: sharer, booking_string: booking_string)

    booking_parser = double
    expect(Utilities::BookingParser).to receive(:new).with(booking_string).and_return booking_parser

    parsed_booking = double(begins_at: Time.now, ends_at: Time.now + 2.hours)
    expect(booking_parser).to receive(:parse).and_return parsed_booking

    expect(Booking).to receive(:create).with(car: car, sharer: sharer, begins_at: parsed_booking.begins_at, ends_at: parsed_booking.ends_at)

    book.execute

    expect(book).to have_response_from_car("You have booked the car from #{format_time parsed_booking.begins_at} to #{format_time parsed_booking.ends_at}.")
  end
end
