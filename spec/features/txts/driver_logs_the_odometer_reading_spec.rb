feature 'Driver logs the odometer reading' do
  include Rack::Test::Methods

  def app
    Rails.application
  end

  before do
    Car.create
  end

  scenario 'They receive a reply that the reading has been saved' do
    GatewayRepository.gateway = double

    expect_txt_response "Set odometer reading to 12345"
    send_txt '12345'
  end
end
