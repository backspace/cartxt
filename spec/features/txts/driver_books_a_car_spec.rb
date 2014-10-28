feature 'Driver books a car' do
  include Rack::Test::Methods

  def app
    Rails.application
  end

  let!(:car) { Car.create(number: 'Bot') }
  let!(:booker) { Sharer.create(number: '#booker', status: 'approved') }

  let!(:booking_begins_at) { (Time.now + 1.day).change(hour: 15, min: 0, sec: 0) }
  let!(:booking_ends_at) { booking_begins_at + 2.hours }

  def format_time(time)
    time.strftime("%Y-%m-%e %l:%M%p")
  end

  scenario 'They receive a reply that they have booked the car' do
    GatewayRepository.gateway = double

    expect_txt_response "You have booked the car from #{format_time booking_begins_at} to #{format_time booking_ends_at}."
    send_txt "book from #{format_time booking_begins_at} to #{format_time booking_ends_at}"
  end
end
