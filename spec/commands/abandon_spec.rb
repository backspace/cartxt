describe Commands::Abandon do
  let(:sharer) { double(:sharer) }
  let(:car) { :car }

  def create_unconfirmed_booking
    expect(Booking).to receive(:unconfirmed_for).with(car, sharer).and_return(found_bookings)
  end

  def abandon
    @abandon ||= Commands::Abandon.new(car: car, sharer: sharer, identifier: identifier)
  end

  context "when an identifier is given" do
    let(:identifier) { "1" }

    context "when there is a corresponding booking" do
      let(:booking) { double(:booking) }
      let(:found_bookings) { double(:bookings) }

      it "abandons the booking and responds" do
        expect(sharer).to receive(:bookings).and_return(double(upcoming: found_bookings))
        expect(found_bookings).to receive(:[]).with(identifier.to_i - 1).and_return booking
        expect(booking).to receive(:abandon!)

        expect(Responses::AbandonExistingBooking).to receive(:new).with(car: car, sharer: sharer, booking: booking).and_return(response = double)

        abandon.execute
        expect(abandon.responses).to include(response)
      end
    end

    context "when there is no corresponding booking" do
      let(:found_bookings) { double(:bookings) }

      it "responds with a failure" do
        expect(sharer).to receive(:bookings).and_return(double(upcoming: found_bookings))
        expect(found_bookings).to receive(:[]).with(identifier.to_i - 1).and_return nil

        expect(Responses::AbandonExistingBookingNotFoundFailure).to receive(:new).with(car: car, sharer: sharer).and_return(response = double)

        abandon.execute
        expect(abandon.responses).to include(response)
      end
    end
  end

  context "when no identifier is given" do
    let(:identifier) { nil }

    context 'when there is an unconfirmed booking' do
      let(:unconfirmed_booking) { double }
      let(:found_bookings) { [unconfirmed_booking] }

      before do
        create_unconfirmed_booking
      end

      it 'abandons the booking and responds' do
        expect(Responses::Abandon).to receive(:new).with(car: car, sharer: sharer, booking: unconfirmed_booking).and_return(response = double)
        expect(unconfirmed_booking).to receive(:abandon!)

        abandon.execute

        expect(abandon.responses).to include(response)
      end
    end

    context 'when there is no unconfirmed booking' do
      let(:found_bookings) { [] }

      before do
        create_unconfirmed_booking
      end

      it 'responds that there is no unconfirmed booking' do
        expect(Responses::AbandonNoUnconfirmedBookingFailure).to receive(:new).with(car: car, sharer: sharer).and_return(response = double)

        abandon.execute

        expect(abandon.responses).to include(response)
      end
    end
  end
end

