feature 'Driver checks and updates their balance' do
  include Rack::Test::Methods

  def app
    Rails.application
  end

  let!(:car) { FactoryGirl.create :car, lockbox_information: "The lockbox is somewhere." }
  let!(:sharer) { FactoryGirl.create :sharer, balance: 12.34 }
  let!(:admin) { FactoryGirl.create :sharer, :admin, number: '#admin' }

  scenario 'They receive a reply with their current balance' do
    GatewayRepository.gateway = double

    expect_txt_response "Your balance owing is $12.34, with pending payments of $0.00."
    send_txt "balance"

    expect_txt_response "Place your payment in the lockbox. The lockbox is somewhere. After your pending payment of $10.01, your balance will be $2.33."
    expect_txt_response_to admin.number, "#{Formatters::Sharer.new(sharer).format} is submitting a payment of $10.01."
    send_txt "pay 10.01"

    expect_txt_response_to admin.number, "Deducted $10.01 from the balance of #{Formatters::Sharer.new(sharer).format}. Their balance is now $2.33."
    expect_txt_response_to sharer.number, "Your payment of $10.01 has been received. Your balance owing is now $2.33."
    send_txt_from admin.number, "collect 10.01 #{sharer.number}"
  end
end
