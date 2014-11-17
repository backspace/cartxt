feature "Admin can view user list" do
  let!(:car) { create :car }
  let!(:sharer) { create :sharer }

  let!(:admin) { create :user, :admin }

  let!(:sita) { create :user, name: "Sita" }
  let!(:rama) { create :user, name: "Rama" }

  scenario "They view the list" do
    signin admin.email, admin.password

    click_link "Users"

    expect(page).to have_content sita.name
    expect(page).to have_content sita.email

    expect(page).to have_content rama.name
    expect(page).to have_content rama.email
  end

  scenario "but a non-admin cannot" do
    signin sita.email, sita.password

    visit users_path

    expect(page).not_to have_content rama.name
  end
end
