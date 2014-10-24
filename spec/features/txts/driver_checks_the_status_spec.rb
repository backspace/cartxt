feature 'Driver checks the status' do
  include Rack::Test::Methods

  def app
    Rails.application
  end

  let(:reading) { 12345 }

  before do
    car = Car.create(odometer_reading: reading)
  end

  scenario 'They receive a reply with the current odometer reading' do
    GatewayRepository.gateway = double

    expect(GatewayRepository.gateway).to receive(:deliver).with(from: 'Bot', to: 'Driver', body: "The odometer reading is #{reading}")
    send_txt 'status'
  end

  scenario 'They receive a reply after having set the reading' do
    GatewayRepository.gateway = double

    reading = 100
    expect(GatewayRepository.gateway).to receive(:deliver).with(from: 'Bot', to: 'Driver', body: "Set odometer reading to #{reading}")
    send_txt reading

    expect(GatewayRepository.gateway).to receive(:deliver).with(from: 'Bot', to: 'Driver', body: "The odometer reading is #{reading}")
    send_txt 'status'
  end
end
