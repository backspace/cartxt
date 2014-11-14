feature "Rate is saved at the beginning of a borrowing", :txt do
  let!(:car) { create(:car, rate: 0.1) }
  let!(:sharer) { create :sharer }

  let!(:booking) { create :booking, :current, car: car, sharer: sharer }

  scenario "The borrowing is isolated from the rate change" do
    expect("borrow").to produce_response "I am yours until #{Formatters::RelativeTime.new(booking.ends_at).format}. My current rate is $0.10/km. What is my odometer reading?"

    expect("0").to produce_irrelevant_response

    car.rate = 0.2
    car.save

    expect("return").to produce_response "Thanks for the ride! What is my odometer reading?"
    expect("10").to produce_response "Thanks, I updated the records with a reading of 10km. Wow, we drove 10km! That brings your balance to $1.00."
  end
end
