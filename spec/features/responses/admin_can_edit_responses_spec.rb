feature "Admin can edit responses" do
  include Rack::Test::Methods

  def app
    Rails.application
  end

  let!(:car) { FactoryGirl.create(:car) }
  let!(:sharer) { FactoryGirl.create(:sharer) }

  scenario "An admin changes a simple response" do
    return_failure_response = "The new return failure response"

    GatewayRepository.gateway = double

    # FIXME Use Warden login
    admin = FactoryGirl.create(:user, :admin)
    signin(admin.email, admin.password)

    visit responses_path
    fill_in "return_failure", with: return_failure_response
    click_button "Save"

    expect_txt_response return_failure_response
    send_txt "return"
  end
end
