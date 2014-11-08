describe Services::DeletesUnconfirmedBookings do
  let(:sharer) { :sharer }
  let(:car) { :car }

  let(:first_booking) { double(:booking) }
  let(:second_booking) { double(:booking) }
  let(:bookings) { [first_booking, second_booking] }

  it 'finds and deletes unconfirmed bookings' do
    expect(Booking).to receive(:unconfirmed_for).with(car, sharer).and_return(bookings)
    expect(first_booking).to receive(:delete)
    expect(second_booking).to receive(:delete)

    Services::DeletesUnconfirmedBookings.new(car, sharer).delete_unconfirmed_bookings
  end
end
