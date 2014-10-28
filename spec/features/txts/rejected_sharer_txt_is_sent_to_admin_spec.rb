feature 'Rejected sharer sends a txt' do
  include Rack::Test::Methods

  def app
    Rails.application
  end

  before do
    Car.create(number: 'Bot')
  end

  let(:admin) { Sharer.create(name: 'Admin', number: "#admin", role: 'admin') }
  let(:rejected) { Sharer.create(name: 'Rejected', number: "#rejected", status: 'rejected') }
  let(:txt) { 'Hi!!!!' }

  scenario 'Their message is forwarded to the admin' do
    GatewayRepository.gateway = double

    expect_txt_response_to admin.number, "Rejected sharer #{rejected.name} at number #{rejected.number} sent this and we ignored it: #{txt}"
    send_txt_from rejected.number, txt
  end
end
