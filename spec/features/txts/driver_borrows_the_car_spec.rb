feature 'Driver borrows the car' do
  include Rack::Test::Methods

  def app
    Rails.application
  end

  before do
    Car.create
  end

  scenario 'They receive a reply that they have borrowed the car' do
    GatewayRepository.gateway = double

    expect_txt_response "The car is yours!"
    send_txt 'borrow'
  end
end
