feature "Site displays bookings", :txt do
  let!(:car) { create :car }

  let!(:sita_site) { create :user }
  let!(:rama_site) { create :user }

  let!(:admin) { create :user, :admin }

  let!(:sita_phone) { create :sharer, name: "sita", email: sita_site.email }
  let!(:rama_phone) { create :sharer, name: "rama", email: rama_site.email }

  before do
    expect(sita_phone.number => "book tomorrow from 8am to 9am").to produce_irrelevant_response
    expect(sita_phone.number => "confirm").to produce_irrelevant_response

    expect(rama_phone.number => "book tomorrow from 1pm to 3pm").to produce_irrelevant_response
    expect(rama_phone.number => "confirm").to produce_irrelevant_response
  end

  scenario "Sita sees only her booking named on the site", js: true do
    signin(sita_site.email, sita_site.password)

    visit bookings_path

    ensure_page_displays_date(page, Time.now + 1.day)

    within :xpath, "//*[*[@data-start = '8:00']]" do
      expect(page).to have_content "sita"
    end

    within :xpath, "//*[*[@data-start = '1:00']]" do
      expect(page).to_not have_content "rama"
    end
  end

  scenario "Admin sees all bookings named on the site", js: true do
    signin(admin.email, admin.password)

    visit bookings_path

    ensure_page_displays_date(page, Time.now + 1.day)

    within :xpath, "//*[*[@data-start = '8:00']]" do
      expect(page).to have_content "sita"
    end

    within :xpath, "//*[*[@data-start = '1:00']]" do
      expect(page).to have_content "rama"
    end
  end

  def ensure_page_displays_date(page ,date)
    booking_date_string = date.strftime("%a %-m/%-d")
    until page.has_content?(booking_date_string) do
      find(".fc-icon-right-single-arrow").click
    end
  end
end
