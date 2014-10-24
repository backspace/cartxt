feature 'Txts are logged' do
  include Rack::Test::Methods

  def app
    Rails.application
  end

  scenario 'A user can view the txts' do
    # FIXME centralise gateway double?
    GatewayRepository.gateway = NullGateway.new

    # FIXME must have a car for now
    Car.create
    send_txt 'hello this is a txt'

    visit txts_path
    expect(page).to have_content 'hello this is a txt'
  end
end
