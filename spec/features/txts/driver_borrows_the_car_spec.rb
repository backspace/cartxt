feature 'Driver borrows the car' do
  include Rack::Test::Methods

  def app
    Rails.application
  end

  before do
    Car.create(number: 'Bot')
  end

  scenario 'They receive a reply that they have borrowed the car' do
    GatewayRepository.gateway = double

    expect_txt_response "The car is yours! What is the odometer reading?"
    send_txt 'borrow'

    expect_txt_response "Set odometer reading to 500"
    send_txt "500"
  end
end
