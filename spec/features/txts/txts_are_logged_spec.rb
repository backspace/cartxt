feature 'Txts are logged' do
  include Rack::Test::Methods

  def app
    Rails.application
  end

  scenario 'A user can view the txts' do
    # FIXME centralise gateway double?
    GatewayRepository.gateway = NullGateway.new

    # FIXME must have a car for now
    Car.create(number: 'Bot')
    send_txt 'status'

    visit txts_path
    expect(page).to have_content 'status'
  end
end
