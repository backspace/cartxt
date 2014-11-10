feature "Driver abandons their booking", :txt do
  let!(:car) { create :car }
  let!(:sharer) { create :sharer }

  scenario "They see no upcoming bookings" do
    expect("book tomorrow from 6a to 7a").to produce_irrelevant_response
    expect("confirm").to produce_irrelevant_response

    expect("book tomorrow from 8a to 9a").to produce_irrelevant_response
    expect("confirm").to produce_irrelevant_response

    expect("book tomorrow from 10a to 11a").to produce_irrelevant_response
    expect("confirm").to produce_irrelevant_response

    expect("abandon #2").to produce_response "Abandoned your booking tomorrow from 8:00AM to 9:00AM."
    expect("abandon #1").to produce_response "Abandoned your booking tomorrow from 6:00AM to 7:00AM."
    expect("abandon #1").to produce_response "Abandoned your booking tomorrow from 10:00AM to 11:00AM."

    expect("bookings").to produce_response "You have no upcoming bookings.\n"
  end

  scenario "They cannot abandon a non-existent booking" do
    expect("abandon 1").to produce_response "Booking not found."
  end
end
