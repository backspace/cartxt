feature "Admin sets up the application", :txt do
  let!(:admin) { create :user, :admin }

  scenario "They do not have a number" do
    they_sign_in
    they_describe_the_car

    select "Canada (+1)", from: "phone_number_region_country"
    select "204 (MB)", from: "phone_number_region_area_code"

    expect(BuysNumbers).to receive(:new).with(hash_including(area_code: "204", country: "CA")).and_return(buyer = double)
    expect(buyer).to receive(:buy_number).and_return(number = "1234")

    click_button "Buy Number"

    expect(page).to have_content "the phone number #{number}"

    fill_in "Name", with: "Francine"
    fill_in "Number", with: "5678"

    expect_txt_response_from_and_to number, "5678", "Hello!"
    click_button "Txt Admin"
  end

  scenario "They already have a number" do
    they_sign_in
    they_describe_the_car

    number = "885"

    fill_in "Number", with: number
    click_button "Update Car"

    expect(page).to have_content "the phone number #{number}"
  end

  def they_sign_in
    visit root_path

    fill_in "Email", with: admin.email
    fill_in "Password", with: admin.password

    click_button "Sign in"

    expect(page).to have_content "Car details"
  end

  def they_describe_the_car
    fill_in "Description", with: "A description."
    fill_in "Location information", with: "The location."
    fill_in "Lockbox information", with: "The key."
    click_button "Create Car"

    expect(page).to have_content "Car txting number"
  end
end
