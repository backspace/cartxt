feature "Driver abandons their booking", :txt do
  let!(:car) { create :car }
  let!(:sharer) { create :sharer }

  scenario "They see no upcoming bookings" do
    expect("book tomorrow from 8a to 9a").to produce_irrelevant_response
    expect("confirm").to produce_irrelevant_response

    expect("abandon 1").to produce_response "Abandoned your booking tomorrow from 8:00AM to 9:00AM."
    expect("bookings").to produce_response "You have no upcoming bookings.\n"
  end

  scenario "They cannot abandon a non-existent booking" do
    expect("abandon 1").to produce_response "Booking not found."
  end
end
