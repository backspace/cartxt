feature "Driver connects with their email address", :txt do
  let!(:car) { create :car }
  let!(:sharer) { create :sharer, balance: 35 }

  let!(:user) { create :user }

  scenario "The sharer registers their email address and it shows on the site", js: true do
    expect("email #{user.email}").to produce_response "I recorded your email address as #{user.email}. You can now check your balance on the site."

    signin(user.email, user.password)

    visit root_path

    expect(page).to have_content("$35.00")
  end
end
