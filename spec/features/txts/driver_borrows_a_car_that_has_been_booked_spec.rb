feature 'Driver borrows a car that has been booked', :txt do
  let!(:car) { FactoryGirl.create :car, rate: 1 }

  let!(:booker) { FactoryGirl.create :sharer }
  let!(:borrower) { FactoryGirl.create :sharer, number: '#borrower' }

  let!(:booking_begins_at) { (Time.now + 1.day).change(hour: 15, min: 0, sec: 0) }
  let!(:booking_ends_at) { booking_begins_at + 2.hours }

  before do
    Booking.create(car: car, sharer: booker, begins_at: booking_begins_at, ends_at: booking_ends_at)
  end

  scenario 'They get a notice of the next booking' do
    expect_txt_response_to borrower.number, "I am yours! My current rate is $1.00/km. Note that it is booked as of #{booking_begins_at.to_formatted_s}. What is my odometer reading?"
    send_txt_from borrower.number, "borrow"
  end
end
