feature "Admin updates car details", :txt do
  let!(:car) { create :car }
  let!(:admin) { create :user, :admin }

  let!(:sharer) { create :sharer }

  before do
    # Hack the status response to include all car information
    Response.create(name: "status_available", body: "{{car.description}} {{car.location_information}} {{car.lockbox_information}}")
  end

  scenario "Car details are saved" do
    signin(admin.email, admin.password)

    visit root_path
    click_link "Edit car details"

    fill_in "car_description", with: "I am a car."
    fill_in "car_location_information", with: "I am parked somewhere."
    fill_in "car_lockbox_information", with: "The key is somewhere."

    click_button "Update Car"

    expect("status").to produce_response "I am a car. I am parked somewhere. The key is somewhere."
  end
end
