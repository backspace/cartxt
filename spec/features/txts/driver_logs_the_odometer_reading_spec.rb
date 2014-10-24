feature 'Driver logs the odometer reading' do
  include Rack::Test::Methods

  def app
    Rails.application
  end

  scenario 'They receive a reply that the reading has been saved' do
    GatewayRepository.gateway = double

    expect(GatewayRepository.gateway).to receive(:deliver).with(from: 'Bot', to: 'Driver', body: 'Set odometer reading to 12345')
    post '/txts', From: 'Driver', To: 'Bot', Body: '12345'
  end
end
