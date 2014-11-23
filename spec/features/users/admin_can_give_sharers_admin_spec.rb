feature "Admin can give sharers admin", :txt do
  let!(:admin) { create :user, :admin }

  let!(:car) { create :car }
  let!(:sharer) { create :sharer }

  scenario "the new sharer sees the admin commands listed" do
    signin admin.email, admin.password

    click_link "Sharers"

    within "tr", text: sharer.number do
      check "sharer[admin]"
      click_button "Save"
    end

    expect("commands").to produce_responses [Responses::Commands.default_body, Responses::CommandsAdmin.default_body]
  end
end
