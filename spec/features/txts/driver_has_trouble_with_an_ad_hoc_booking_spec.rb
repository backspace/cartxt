feature "Driver has trouble with an ad hoc booking", :txt do
  let!(:car) { create :car, rate: 0 }
  let!(:sharer) { create :sharer }

  before do
    Timecop.freeze(Time.local(2014, 11, 15, 15, 0, 0))
  end

  after do
    Timecop.return
  end

  let!(:existing_booking) { create :booking, car: car, begins_at: Time.now + 2.hours, ends_at: Time.now + 3.hours }

  scenario "They try to book past an existing booking" do
    expect("borrow").to produce_response "How long do you want the car for? Say something like \"until tomorrow at 10AM\" or \"until 1pm\". The next booking begins today (Saturday) at 5:00PM."

    expect("until 7pm").to produce_response "Sorry, the car is already booked today (Saturday) from 5:00PM to 6:00PM."

    expect("until 430pm").to produce_response "The car is yours until today (Saturday) at 4:30PM. The current rate is $0.00/km. What is the odometer reading?"
  end
end
