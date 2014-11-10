feature "Driver lists their bookings", :txt do
  before do
    Timecop.freeze(Time.local(2014, 11, 10, 1, 0, 0))
  end

  after do
    Timecop.return
  end

  let!(:car) { create :car }
  let!(:sharer) { create :sharer }

  let!(:old_booking) { create :booking, sharer: sharer, car: car, begins_at: Time.now - 5.days, ends_at: Time.now - 5.days + 1.hour }

  scenario "They see their upcoming bookings" do
    expect("book tomorrow from 8a to 9a").to produce_irrelevant_response
    expect("confirm").to produce_irrelevant_response
    first = Booking.last

    expect("book tomorrow from 7p to 9p").to produce_irrelevant_response
    expect("confirm").to produce_irrelevant_response
    second = Booking.last

    expect("bookings").to produce_response <<-TXT.strip_heredoc
      Your bookings:
      #1: tomorrow (Tuesday) from 8:00AM to 9:00AM
      #2: tomorrow (Tuesday) from 7:00PM to 9:00PM

      To abandon booking #1, send \"abandon #1\".
    TXT
  end

  scenario "They see no upcoming bookings" do
    expect("bookings").to produce_response "You have no upcoming bookings.\n"
  end
end
