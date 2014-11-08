describe Commands::Book do
  let(:sharer) { :sharer }
  let(:car) { :car }

  let(:booking_string) { :booking_string }
  let(:parsed_booking) { parsed_booking = double(begins_at: Time.now, ends_at: Time.now + 2.hours) }

  before do
    booking_parser = double
    expect(Parsers::Booking).to receive(:new).with(booking_string).and_return booking_parser

    expect(booking_parser).to receive(:parse).and_return parsed_booking
  end

  context 'when the booking is valid' do
    before do
      expect(Validators::Booking).to receive(:new).with(car: car, booking: parsed_booking).and_return validator = double
      expect(validator).to receive(:valid?).and_return true
    end

    it 'deletes existing bookings, creates a booking, and responds' do
      expect(Services::DeletesUnconfirmedBookings).to receive(:new).with(car, sharer).and_return deleter = double
      expect(deleter).to receive(:delete_unconfirmed_bookings)

      book = Commands::Book.new(car: car, sharer: sharer, booking_string: booking_string)

      expect(Booking).to receive(:create).with(car: car, sharer: sharer, begins_at: parsed_booking.begins_at, ends_at: parsed_booking.ends_at).and_return(booking = double)

      expect(Responses::Book).to receive(:new).with(car: car, sharer: sharer, booking: booking).and_return(response = double)

      book.execute

      expect(book.responses).to include(response)
    end
  end

  context 'when the booking is invalid' do
    before do
      expect(Validators::Booking).to receive(:new).with(car: car, booking: parsed_booking).and_return @validator = double
      expect(@validator).to receive(:valid?).and_return false
    end

    it 'deletes existing bookings and delegates to the BookFailure generator' do
      expect(Services::DeletesUnconfirmedBookings).to receive(:new).with(car, sharer).and_return deleter = double
      expect(deleter).to receive(:delete_unconfirmed_bookings)

      book = Commands::Book.new(car: car, sharer: sharer, booking_string: booking_string)

      expect(Responses::Generators::BookFailure).to receive(:new).with(car: car, sharer: sharer, validator: @validator).and_return generator = double
      expect(generator).to receive(:responses).and_return [response = double]

      book.execute

      expect(book.responses).to include(response)
    end
  end
end
