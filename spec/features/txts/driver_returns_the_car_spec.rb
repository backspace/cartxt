feature 'Driver returns the car' do
  include Rack::Test::Methods

  def app
    Rails.application
  end

  before do
    Car.create(number: 'Bot')
  end

  scenario 'They receive a reply that they have return the car' do
    GatewayRepository.gateway = double

    expect_txt_response "Thanks!"
    send_txt 'return'
  end
end
