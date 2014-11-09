require 'support/helpers/session_helpers'
RSpec.configure do |config|
  config.include Features::SessionHelpers, type: :feature
  config.include Features::TxtHelpers, type: :feature

  # FIXME is it possible to include this?
  config.before(:example, :txt) do
    GatewayRepository.gateway = double
  end
end
