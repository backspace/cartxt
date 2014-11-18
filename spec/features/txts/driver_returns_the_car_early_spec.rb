feature "Driver returns the car early", :txt do
  let!(:car) { create :car, rate: 0 }
  let!(:sharer) { create :sharer }

  let(:start) { Time.local(2014, 11, 18, 11, 0, 0) }

  after do
    Timecop.return
  end

  scenario "The booking end time is adjusted", versioning: true do
    Timecop.freeze start

    expect("borrow").to produce_response "Yay! How long do you want me for? Say something like \"until tomorrow at 10AM\" or \"until 1pm\"."

    expect("until 1pm").to produce_response "I am yours until today (Tuesday) at 1:00PM. My current rate is $0.00/km. What is my odometer reading?"

    expect(Booking.first.ends_at).to eq(start + 2.hours)

    expect("0").to produce_irrelevant_response

    Timecop.freeze start + 1.hour

    expect("return").to produce_irrelevant_response
    expect("100").to produce_irrelevant_response

    # TODO expose booking time?
    expect(Booking.first.ends_at).to eq(start + 1.hour)
    expect(Booking.first.previous_version.ends_at).to eq(start + 2.hours)
  end
end
