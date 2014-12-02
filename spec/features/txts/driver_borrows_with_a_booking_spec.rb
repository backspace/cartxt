feature "Driver borrows with a booking", :txt do
  let!(:car) { create :car, rate: 0.25 }
  let!(:sharer) { create :sharer }

  let!(:ends_at) { Time.now + 2.hours }

  let!(:booking) { create :booking, car: car, sharer: sharer, begins_at: Time.now - 10.minutes, ends_at: ends_at }

  scenario "They are reminded of the booking end time" do
    expect("Borrow").to produce_response "The car is yours until #{Formatters::RelativeTime.new(ends_at).format}. The current rate is $0.25/km. What is the odometer reading?"
  end
end
