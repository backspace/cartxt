feature 'Driver says something unrecognised' do
  include Rack::Test::Methods

  def app
    Rails.application
  end

  let!(:car) { FactoryGirl.create :car }
  let!(:sharer) { FactoryGirl.create :sharer }

  scenario "They receive the commands response" do
    GatewayRepository.gateway = double

    expect_txt_response Responses::Commands.default_body
    send_txt "hello"
  end
end
