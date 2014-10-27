feature 'Driver returns the car' do
  include Rack::Test::Methods

  def app
    Rails.application
  end

  before do
    Car.create(number: 'Bot', status: 'borrowed')
  end

  scenario 'They receive a reply that they have return the car' do
    GatewayRepository.gateway = double

    expect_txt_response "Thanks! What is the odometer reading?"
    send_txt 'return'

    expect_txt_response "Set odometer reading to 800"
    send_txt "800"
  end
end
