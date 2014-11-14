RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller

  config.before(:example, :devise) do
    create :car
  end
end
