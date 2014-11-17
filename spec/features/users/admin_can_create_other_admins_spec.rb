feature "Admin can create other admins" do
  let!(:admin) { create :user, :admin, name: "Original Admin" }
  let!(:neophyte) { create :user, name: "Neophyte" }

  scenario "the new admin can see the user list" do
    signin admin.email, admin.password

    click_link "Users"

    within "tr", text: neophyte.email do
      check "user[admin]"
      click_button "Save"
    end

    in_browser(:neophyte) do
      signin neophyte.email, neophyte.password

      click_link "Users"

      expect(page).to have_content "Original Admin"
    end
  end
end
