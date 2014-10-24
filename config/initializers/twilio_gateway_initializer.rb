unless Rails.env.test?
  GatewayRepository.gateway = TwilioGateway.new(Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])) if ENV['TWILIO_ACCOUNT_SID']
end
