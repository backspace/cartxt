feature "Driver arrives early for their booking", :txt do
  let!(:car) { create :car, rate: 0 }
  let!(:sharer) { create :sharer }

  let(:booking_start) { Time.local(2014, 11, 20, 10, 0, 0) }

  let(:booking) { create :booking, sharer: sharer, car: car, begins_at: booking_start, ends_at: booking_start + 1.hour }

  after do
    Timecop.return
  end

  scenario "The booking is adjusted to start early", versioning: true do
    # Create the booking early to avoid versioning time crisis
    Timecop.freeze booking_start - 2.hours
    booking
    Timecop.freeze booking_start - 30.minutes

    # FIXME could note earliness (had "Ooo, early! I forgive you.")
    # How to detect with versioning though?

    expect("borrow").to produce_response "I am yours until today (Thursday) at 11:00AM. My current rate is $0.00/km. What is my odometer reading?"

    booking.reload

    expect(booking.begins_at).to eq(booking_start - 30.minutes)
    expect(booking.previous_version.begins_at).to eq(booking_start)
  end
end
