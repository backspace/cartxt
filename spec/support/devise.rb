RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller

  # Prevents being routed to the setup wizard
  config.before(:example, :devise) do
    create :car
    create :sharer
  end
end
