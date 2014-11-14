feature "Driver abandons their booking", :txt do
  before do
    Timecop.freeze(Time.local(2014, 11, 10, 1, 0, 0))
  end

  after do
    Timecop.return
  end

  let!(:car) { create :car }
  let!(:sharer) { create :sharer }

  scenario "They see no upcoming bookings" do
    # Booking #2:
    expect("book tomorrow from 8am to 9am").to produce_irrelevant_response
    expect("confirm").to produce_irrelevant_response

    # Booking #3:
    expect("book tomorrow from 10am to 11am").to produce_irrelevant_response
    expect("confirm").to produce_irrelevant_response

    # Booking #1:
    expect("book tomorrow from 6am to 7am").to produce_irrelevant_response
    expect("confirm").to produce_irrelevant_response

    expect("abandon #2").to produce_response "Abandoned your booking tomorrow (Tuesday) from 8:00AM to 9:00AM."
    expect("abandon #1").to produce_response "Abandoned your booking tomorrow (Tuesday) from 6:00AM to 7:00AM."
    expect("abandon #1").to produce_response "Abandoned your booking tomorrow (Tuesday) from 10:00AM to 11:00AM."

    expect("bookings").to produce_response "You have no upcoming bookings.\n"
  end

  scenario "They cannot abandon a non-existent booking" do
    expect("abandon 1").to produce_response "Booking not found."
  end
end
