RSpec.configure do |config|
  config.before(:example, :txt) do
    GatewayRepository.gateway = double
    allow(GatewayRepository.gateway).to receive(:deliver_original_copies)
  end

  config.before(type: :feature, txt: true) do
    def app
      Rails.application
    end
  end

  config.include Rack::Test::Methods, type: :feature, txt: true
end
