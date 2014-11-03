feature "Admin can edit responses" do
  include Rack::Test::Methods

  def app
    Rails.application
  end

  let!(:car) { FactoryGirl.create(:car) }
  let!(:sharer) { FactoryGirl.create(:sharer) }

  before do
    # FIXME Use Warden login
    admin = FactoryGirl.create(:user, :admin)
    signin(admin.email, admin.password)
  end

  scenario "An admin changes a simple response" do
    return_failure_response = "The new return failure response"

    GatewayRepository.gateway = double

    visit responses_path
    fill_in "return_failure", with: return_failure_response
    click_button "return_failure_submit"

    expect_txt_response return_failure_response
    send_txt "return"
  end

  scenario "An admin changes a template-like response" do
    sharer.status = "unnamed"
    sharer.save

    name_response = "Hello, {{sender_name}}!"

    GatewayRepository.gateway = double

    visit responses_path
    fill_in "name", with: name_response
    click_button "name_submit"

    expect_txt_response "Hello, Francine!"
    send_txt "Francine"
  end
end
