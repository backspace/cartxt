feature 'Driver borrows a car that has been booked' do
  include Rack::Test::Methods

  def app
    Rails.application
  end

  let!(:car) { Car.create(number: 'Bot') }

  let!(:booker) { Sharer.create(number: '#booker', status: 'approved') }
  let!(:borrower) { Sharer.create(number: '#borrower', status: 'approved') }

  let!(:booking_begins_at) { (Time.now + 1.day).change(hour: 15, min: 0, sec: 0) }
  let!(:booking_ends_at) { booking_begins_at + 2.hours }

  before do
    Booking.create(car: car, sharer: booker, begins_at: booking_begins_at, ends_at: booking_ends_at)
  end

  scenario 'They get a notice of the next booking' do
    GatewayRepository.gateway = double

    expect_txt_response "The car is yours! Note that it is booked as of #{booking_begins_at.strftime("%Y-%m-%e %l:%M%p")}. What is the odometer reading?"
    send_txt "borrow"
  end
end
