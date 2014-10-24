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
    post '/txts', From: 'Driver', To: 'Bot', Body: 'status'
  end
end
