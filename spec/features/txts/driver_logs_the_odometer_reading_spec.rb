feature 'Driver logs the odometer reading' do
  include Rack::Test::Methods

  def app
    Rails.application
  end

  before do
    @car = Car.new(number: 'Bot', status: 'borrowed')
    @car.save
  end

  scenario 'They receive a rejection when the new reading is lower than the current one' do
    @car.odometer_reading = 100
    @car.save

    GatewayRepository.gateway = double

    expect_txt_response "Unable to set odometer reading to 50, which is lower than the current reading of 100"
    send_txt "50"
  end
end
