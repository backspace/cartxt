describe Commands::Book do
  let(:sharer) { :sharer }
  let(:car) { :car }

  let(:booking_string) { :booking_string }
  let(:parsed_booking) { parsed_booking = double(begins_at: Time.now, ends_at: Time.now + 2.hours) }

  before do
    booking_parser = double
    expect(Utilities::BookingParser).to receive(:new).with(booking_string).and_return booking_parser

    expect(booking_parser).to receive(:parse).and_return parsed_booking
  end

  context 'when there is an unconfirmed booking' do
    let(:unconfirmed_booking) { double }
    let(:found_bookings) { [unconfirmed_booking] }

    before do
      expect(Booking).to receive(:unconfirmed_for).with(car, sharer).and_return(found_bookings)
    end

    context 'when there is no overlapping booking' do
      before do
        expect(BookingConflictFinder).to receive(:new).with(car: car, proposed_booking: parsed_booking, excluding: unconfirmed_booking).and_return(finder = double)
        expect(finder).to receive(:conflict?).and_return false
      end

      it 'updates the existing booking and responds' do
        book = Commands::Book.new(car: car, sharer: sharer, booking_string: booking_string)

        expect(Responses::BookUpdate).to receive(:new).with(car: car, sharer: sharer, booking:unconfirmed_booking).and_return(response = double)

        expect(unconfirmed_booking).to receive(:begins_at=).with(parsed_booking.begins_at)
        expect(unconfirmed_booking).to receive(:ends_at=).with(parsed_booking.ends_at)
        expect(unconfirmed_booking).to receive(:save)

        book.execute

        expect(book.responses).to include(response)
      end
    end

    context 'when there is an overlapping booking' do
      let(:conflicting_booking) { double(:conflicting_booking) }

      before do
        expect(BookingConflictFinder).to receive(:new).with(car: car, proposed_booking: parsed_booking, excluding: unconfirmed_booking).and_return(finder = double)
        expect(finder).to receive(:conflict?).and_return true
        expect(finder).to receive(:conflicting_booking).and_return(conflicting_booking)
      end

      it 'deletes the unconfirmed booking and responds with BookFailure' do
        book = Commands::Book.new(car: car, sharer: sharer, booking_string: booking_string)

        expect(Responses::BookFailure).to receive(:new).with(car: car, sharer: sharer, conflicting_booking: conflicting_booking).and_return(response = double)

        expect(unconfirmed_booking).to receive(:delete)

        book.execute

        expect(book.responses).to include(response)
      end
    end
  end

  context 'when there is no overlapping booking' do
    before do
      expect(BookingConflictFinder).to receive(:new).with(car: car, proposed_booking: parsed_booking).and_return(finder = double)
      expect(finder).to receive(:conflict?).and_return false
    end

    it 'creates a booking' do
      book = Commands::Book.new(car: car, sharer: sharer, booking_string: booking_string)

      expect(Booking).to receive(:create).with(car: car, sharer: sharer, begins_at: parsed_booking.begins_at, ends_at: parsed_booking.ends_at).and_return(booking = double)

      expect(Responses::Book).to receive(:new).with(car: car, sharer: sharer, booking: booking).and_return(response = double)

      book.execute

      expect(book.responses).to include(response)
    end
  end

  context 'when there is an overlapping booking' do
    let(:conflicting_booking) { :conflicting_booking }

    before do
      expect(BookingConflictFinder).to receive(:new).with(car: car, proposed_booking: parsed_booking).and_return(finder = double)
      expect(finder).to receive(:conflict?).and_return true
      expect(finder).to receive(:conflicting_booking).and_return(conflicting_booking)
    end

    it 'responds with BookFailure' do
      book = Commands::Book.new(car: car, sharer: sharer, booking_string: booking_string)

      expect(Responses::BookFailure).to receive(:new).with(car: car, sharer: sharer, conflicting_booking: conflicting_booking).and_return(response = double)

      book.execute

      expect(book.responses).to include(response)
    end
  end
end
