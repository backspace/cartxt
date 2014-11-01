feature 'Driver buys some gas' do
  include Rack::Test::Methods

  def app
    Rails.application
  end

  let!(:car) { FactoryGirl.create :car }
  let!(:sharer) { FactoryGirl.create :sharer, balance: 20 }

  scenario 'They receive a reply with their new balance' do
    GatewayRepository.gateway = double

    expect_txt_response "Deducted your gas cost of $5.00. Your balance is now $15.00. Please submit the receipt when you return the key."
    send_txt "gas $5"

    expect_txt_response "Your current balance is $15.00."
    send_txt "balance"
  end
end
