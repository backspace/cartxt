feature 'Driver takes a trip' do
  include Rack::Test::Methods

  def app
    Rails.application
  end

  let!(:car) { FactoryGirl.create(:car, rate: 0.32, location_information: "I am parked behind 100 Main St.", lockbox_information: "The key is in a lockbox at the top of the fire escape, the combination is 1234.") }
  let!(:sharer) { FactoryGirl.create :sharer, balance: 0.32 }

  scenario 'They receive their total owing at the end' do
    GatewayRepository.gateway = double

    expect_txt_response "The car is yours! #{car.location_information} #{car.lockbox_information} What is the odometer reading?"
    send_txt "borrow"

    expect_txt_response "Set odometer reading to 0"
    send_txt "0"

    expect_txt_response "Thanks! What is the odometer reading?"
    send_txt "return"

    expect_txt_response "Set odometer reading to 200. Your balance is $64.32."
    send_txt "200"
  end
end
