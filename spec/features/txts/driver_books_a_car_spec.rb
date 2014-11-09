feature 'Driver books a car', :txt do
  let!(:car) { create :car, location_information: "I am parked somewhere." }
  let!(:booker) { create :sharer }

  let!(:booking_begins_at) { (Time.now + 1.day).change(hour: 15, min: 0, sec: 0) }
  let!(:booking_ends_at) { booking_begins_at + 2.hours }

  def booking_command_for(begins_at, ends_at)
    "book from #{begins_at.to_formatted_s} to #{ends_at.to_formatted_s}" 
  end

  def format_booking(begins_at, ends_at)
    Formatters::Booking.new(OpenStruct.new(begins_at: begins_at, ends_at: ends_at)).format
  end

  # FIXME maybe questionable to use a formatter here?

  def booking_response_for(begins_at, ends_at)
    "You wish to book me #{Formatters::Booking.new(OpenStruct.new(begins_at: begins_at, ends_at: ends_at)).format}? Reply with 'confirm', try another 'book from X to Y', or 'abandon'."
  end

  def booking_confirmation_response_for(begins_at, ends_at)
    "You have booked me #{Formatters::Booking.new(OpenStruct.new(begins_at: begins_at, ends_at: ends_at)).format}. I am parked somewhere. When the time comes, send \"borrow\"."
  end

  def admin_booking_notification_for(sharer, begins_at, ends_at)
    "#{sharer.name} #{sharer.number}, has booked me #{Formatters::Booking.new(OpenStruct.new(begins_at: begins_at, ends_at: ends_at)).format}."
  end

  let(:booking_command) { booking_command_for(booking_begins_at, booking_ends_at) }
  let(:booking_response) { booking_response_for(booking_begins_at, booking_ends_at) }

  scenario 'They receive a reply that they have booked the car, admins are notified, and the booking is visible on the site', js: true do
    expect(booker.number => booking_command).to produce_response booking_response

    nosy_admin = create :sharer, :admin, :notified_of_bookings

    expect(booker.number => "confirm").to produce_responses({
      nosy_admin.number => admin_booking_notification_for(booker, booking_begins_at, booking_ends_at),
      booker.number => booking_confirmation_response_for(booking_begins_at, booking_ends_at)
    })

    user = create :user
    signin(user.email, user.password)

    visit bookings_path

    find(".fc-agendaDay-button").click

    # Assuming booking does not span days
    booking_date_string = booking_begins_at.strftime("%B %-d, %Y")
    until page.has_content?(booking_date_string) do
      find(".fc-icon-right-single-arrow").click
    end

    booking_time_string = "#{booking_begins_at.strftime("%l:%M")} - #{booking_ends_at.strftime("%l:%M")}"
    expect(page).to have_content(booking_time_string)
  end

  scenario 'They receive a reply that the car is already booked at that time' do
    existing_booking = Booking.create(car: car, begins_at: booking_begins_at - 15.minutes, ends_at: booking_ends_at + 15.minutes)

    expect(booker.number => booking_command_for(booking_begins_at, booking_ends_at)).to produce_response "Sorry, I am already booked #{Formatters::Booking.new(existing_booking).format}."
  end

  scenario 'They change their mind about the booking' do
    expect(booking_command).to produce_response booking_response
    expect("abandon").to produce_response "Okay, I abandoned your booking request."
  end

  scenario 'They tweak the booking before confirming' do
    expect(booking_command).to produce_response booking_response

    new_begins_at = booking_begins_at + 2.hours
    new_ends_at = booking_ends_at + 3.hours

    expect(booking_command_for(new_begins_at, new_ends_at)).to produce_response(booking_response_for(new_begins_at, new_ends_at))
    expect("confirm").to produce_response(booking_confirmation_response_for(new_begins_at, new_ends_at))
  end

  scenario 'They get a confused response if they have no booking to confirm' do
    expect("confirm").to produce_response "Sorry, you have no pending booking to confirm! Try making a booking by sending \"book from X to Y\"."
  end

  scenario 'They get a confused response if they have no booking to abandon' do
    expect("abandon").to produce_response "Sorry, you have no pending booking to abandon! Try making a booking by sending \"book from X to Y\"."
  end

  scenario 'They get a failure if the booking is in the past' do
    past_begins_at = booking_begins_at - 5.days
    past_ends_at = booking_ends_at - 5.days

    expect(booking_command_for(past_begins_at, past_ends_at)).to produce_response "Sorry, you cannot book me in the past. You tried to book me #{format_booking(past_begins_at, past_ends_at)}."
  end

  scenario "They get a failure if the booking end is before the beginning" do
    expect(booking_command_for(booking_ends_at, booking_begins_at)).to produce_response "Sorry, you cannot make a booking where the end is before the beginning. You tried to book me #{format_booking(booking_ends_at, booking_begins_at)}."
  end
end
