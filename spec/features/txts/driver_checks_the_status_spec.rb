feature 'Driver checks the status' do
  include Rack::Test::Methods

  def app
    Rails.application
  end

  let(:reading) { 12345 }

  before do
    car = Car.create(number: 'Bot', odometer_reading: reading, status: 'borrowed')
  end

  scenario 'They receive a reply with the current odometer reading' do
    GatewayRepository.gateway = double

    expect_txt_response "The odometer reading is #{reading}"
    send_txt 'status'
  end

  scenario 'They receive a reply after having set the reading' do
    GatewayRepository.gateway = double

    reading = 100
    expect_txt_response "Set odometer reading to #{reading}"
    send_txt reading

    expect_txt_response "The odometer reading is #{reading}"
    send_txt 'status'
  end
end
