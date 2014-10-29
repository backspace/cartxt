feature 'Driver books a car' do
  include Rack::Test::Methods

  def app
    Rails.application
  end

  let!(:car) { FactoryGirl.create :car }
  let!(:booker) { FactoryGirl.create :sharer }

  let!(:booking_begins_at) { (Time.now + 1.day).change(hour: 15, min: 0, sec: 0) }
  let!(:booking_ends_at) { booking_begins_at + 2.hours }

  scenario 'They receive a reply that they have booked the car and the booking is visible on the site', js: true do
    GatewayRepository.gateway = double

    expect_txt_response "You have booked the car from #{booking_begins_at.to_formatted_s} to #{booking_ends_at.to_formatted_s}."
    send_txt_from booker.number, "book from #{booking_begins_at.to_formatted_s} to #{booking_ends_at.to_formatted_s}"

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
end
