feature 'Driver borrows a car that has been booked', :txt do
  let!(:car) { create :car, rate: 1 }

  let!(:booker) { create :sharer }
  let!(:borrower) { create :sharer, number: '#borrower' }

  let!(:borrower_booking) { create :booking, :current, car: car, sharer: borrower }
  let!(:booking_begins_at) { (Time.now + 1.day).change(hour: 15, min: 0, sec: 0) }
  let!(:booking_ends_at) { booking_begins_at + 2.hours }

  before do
    Booking.create(car: car, sharer: booker, begins_at: booking_begins_at, ends_at: booking_ends_at)
  end

  scenario 'They get a notice of the next booking' do
    expect(borrower.number => "borrow").to produce_response(borrower.number => "I am yours until #{Formatters::RelativeTime.new(borrower_booking.ends_at).format}. My current rate is $1.00/km. Note that it is booked as of #{booking_begins_at.to_formatted_s}. What is my odometer reading?")
  end
end
