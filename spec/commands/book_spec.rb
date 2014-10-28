describe Commands::Book do
  let(:sharer) { :sharer }
  let(:car) { :car }

  let(:booking_string) { :booking_string }

  it 'delegates to the booking parser and creates a booking' do
    book = Commands::Book.new(car: car, sharer: sharer, booking_string: booking_string)

    booking_parser = double
    expect(Utilities::BookingParser).to receive(:new).with(booking_string).and_return booking_parser

    parsed_booking = double(begins_at: Time.now, ends_at: Time.now + 2.hours)
    expect(booking_parser).to receive(:parse).and_return parsed_booking

    expect(Booking).to receive(:create).with(car: car, sharer: sharer, begins_at: parsed_booking.begins_at, ends_at: parsed_booking.ends_at)

    book.execute

    expect(book).to have_response_from_car("You have booked the car from #{parsed_booking.begins_at.to_formatted_s} to #{parsed_booking.ends_at.to_formatted_s}.")
  end
end
