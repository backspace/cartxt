describe Commands::Cancel do
  let(:sharer) { :sharer }
  let(:car) { :car }

  def create_unconfirmed_booking
    expect(Booking).to receive(:unconfirmed_for).with(car, sharer).and_return(found_bookings)
  end

  context 'when there is an unconfirmed booking' do
    let(:unconfirmed_booking) { double }
    let(:found_bookings) { [unconfirmed_booking] }

    before do
      create_unconfirmed_booking
    end

    it 'cancels the booking and responds' do
      cancel = Commands::Cancel.new(car: car, sharer: sharer)

      expect(Responses::Cancel).to receive(:new).with(car: car, sharer: sharer, booking: unconfirmed_booking).and_return(response = double)
      expect(unconfirmed_booking).to receive(:cancel!)

      cancel.execute

      expect(cancel.responses).to include(response)
    end
  end

  context 'when there is no unconfirmed booking' do
    let(:found_bookings) { [] }

    before do
      create_unconfirmed_booking
    end

    it 'responds that there is no unconfirmed booking' do
      cancel = Commands::Cancel.new(car: car, sharer: sharer)

      expect(Responses::CancelNoUnconfirmedBookingFailure).to receive(:new).with(car: car, sharer: sharer).and_return(response = double)

      cancel.execute

      expect(cancel.responses).to include(response)
    end
  end
end

