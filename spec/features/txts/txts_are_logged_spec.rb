feature 'Txts are logged', :txt do
  include Rack::Test::Methods

  def app
    Rails.application
  end

  scenario 'A user can view the txts' do
    # FIXME centralise gateway double?
    GatewayRepository.gateway = NullGateway.new

    # FIXME use Warden login?
    admin = FactoryGirl.create(:user, :admin)
    signin(admin.email, admin.password)

    # FIXME must have a car for now
    FactoryGirl.create(:car)
    FactoryGirl.create :sharer
    send_txt 'status'

    visit txts_path
    expect(page).to have_content 'status'
  end
end
