feature 'Driver checks their balance' do
  include Rack::Test::Methods

  def app
    Rails.application
  end

  let!(:car) { FactoryGirl.create :car }
  let!(:sharer) { FactoryGirl.create :sharer, balance: 12.34 }

  scenario 'They receive a reply with their current balance' do
    GatewayRepository.gateway = double

    expect_txt_response "Your current balance is $12.34."
    send_txt "balance"
  end
end
