feature "Admin can view sharer list" do
  let!(:car) { create :car }
  let!(:sharer) { create :sharer }

  let!(:admin) { create :user, :admin }

  let!(:sita) { create :sharer, name: "Sita", email: "sita@example.com" }
  let!(:rama) { create :sharer, name: "Rama" }

  scenario "They view the sharer list" do
    signin admin.email, admin.password

    click_link "Sharers"

    expect(page).to have_content sita.name
    expect(page).to have_content sita.number
    expect(page).to have_content sita.email

    expect(page).to have_content rama.name
    expect(page).to have_content rama.number
  end
end
