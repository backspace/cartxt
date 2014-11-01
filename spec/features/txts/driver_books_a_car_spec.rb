feature 'Driver books a car' do
  include Rack::Test::Methods

  def app
    Rails.application
  end

  let!(:car) { FactoryGirl.create :car, location_information: "I am parked somewhere." }
  let!(:booker) { FactoryGirl.create :sharer }

  let!(:booking_begins_at) { (Time.now + 1.day).change(hour: 15, min: 0, sec: 0) }
  let!(:booking_ends_at) { booking_begins_at + 2.hours }

  def booking_command_for(begins_at, ends_at)
    "book from #{begins_at.to_formatted_s} to #{ends_at.to_formatted_s}" 
  end

  # FIXME maybe questionable to use a formatter here?

  def booking_response_for(begins_at, ends_at)
    "You wish to book me #{Formatters::Booking.new(OpenStruct.new(begins_at: begins_at, ends_at: ends_at)).format}? Reply with 'confirm', try another 'book from X to Y', or 'cancel'."
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
    GatewayRepository.gateway = double

    expect_txt_response booking_response
    send_txt_from booker.number, booking_command

    nosy_admin = FactoryGirl.create :sharer, :admin, :notified_of_bookings

    expect_txt_response booking_confirmation_response_for(booking_begins_at, booking_ends_at)
    expect_txt_response_to nosy_admin.number, admin_booking_notification_for(booker, booking_begins_at, booking_ends_at)
    send_txt_from booker.number, "confirm"

    user = FactoryGirl.create :user
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

    GatewayRepository.gateway = double

    expect_txt_response "Sorry, I am already booked #{Formatters::Booking.new(existing_booking).format}."
    send_txt_from booker.number, "book from #{booking_begins_at.to_formatted_s} to #{booking_ends_at.to_formatted_s}"
  end

  scenario 'They change their mind about the booking' do
    GatewayRepository.gateway = double

    expect_txt_response booking_response
    send_txt booking_command

    expect_txt_response "Okay, I canceled your booking request."
    send_txt "cancel"
  end

  scenario 'They tweak the booking before confirming' do
    GatewayRepository.gateway = double

    expect_txt_response booking_response
    send_txt booking_command

    new_begins_at = booking_begins_at + 2.hours
    new_ends_at = booking_ends_at + 3.hours

    expect_txt_response booking_response_for(new_begins_at, new_ends_at)
    send_txt booking_command_for(new_begins_at, new_ends_at)

    expect_txt_response booking_confirmation_response_for(new_begins_at, new_ends_at)
    send_txt "confirm"
  end

  scenario 'They get a confused response if they have no booking to confirm' do
    GatewayRepository.gateway = double

    expect_txt_response "Sorry, you have no pending booking to confirm! Try making a booking by sending \"book from X to Y\"."
    send_txt "confirm"
  end

  scenario 'They get a confused response if they have no booking to cancel' do
    GatewayRepository.gateway = double

    expect_txt_response "Sorry, you have no pending booking to cancel! Try making a booking by sending \"book from X to Y\"."
    send_txt "cancel"
  end
end
