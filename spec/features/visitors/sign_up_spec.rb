# Feature: Sign up
#   As a visitor
#   I want to sign up
#   So I can visit protected areas of the site
feature 'Sign Up', :devise do

  # Scenario: Visitor can sign up with valid email address and password
  #   Given I am not signed in
  #   When I sign up with a valid email address and password
  #   Then I see a successful sign up message
  scenario 'visitor can sign up with valid email address and password, must be approved' do
    user_email = "test@example.com"
    user_password = "please123"

    admin = create :user, :admin

    sign_up_with(user_email, user_password, user_password)

    expect(page).to have_content I18n.t("devise.registrations.user.signed_up_but_not_approved")

    signin user_email, user_password
    expect(page).to have_content I18n.t("devise.failure.not_approved")

    in_browser(:admin) do
      signin admin.email, admin.password

      # check email for link
      email = ActionMailer::Base.deliveries.last
      expect(email.to).to include(admin.email)
      expect(email.subject).to include(user_email)

      email_link = email.body.raw_source.split.last
      email_link_path = email_link.split(Capybara.server_port.to_s).last

      visit email_link_path

      within "tr", text: user_email do
        check "user[approved]"
        click_button "Save"
      end
    end

    signin user_email, user_password
    expect(page).to have_content I18n.t "devise.sessions.signed_in"
  end

  # Scenario: Visitor cannot sign up with invalid email address
  #   Given I am not signed in
  #   When I sign up with an invalid email address
  #   Then I see an invalid email message
  scenario 'visitor cannot sign up with invalid email address' do
    sign_up_with('bogus', 'please123', 'please123')
    expect(page).to have_content 'Email is invalid'
  end

  # Scenario: Visitor cannot sign up without password
  #   Given I am not signed in
  #   When I sign up without a password
  #   Then I see a missing password message
  scenario 'visitor cannot sign up without password' do
    sign_up_with('test@example.com', '', '')
    expect(page).to have_content "Password can't be blank"
  end

  # Scenario: Visitor cannot sign up with a short password
  #   Given I am not signed in
  #   When I sign up with a short password
  #   Then I see a 'too short password' message
  scenario 'visitor cannot sign up with a short password' do
    sign_up_with('test@example.com', 'please', 'please')
    expect(page).to have_content "Password is too short"
  end

  # Scenario: Visitor cannot sign up without password confirmation
  #   Given I am not signed in
  #   When I sign up without a password confirmation
  #   Then I see a missing password confirmation message
  scenario 'visitor cannot sign up without password confirmation' do
    sign_up_with('test@example.com', 'please123', '')
    expect(page).to have_content "Password confirmation doesn't match"
  end

  # Scenario: Visitor cannot sign up with mismatched password and confirmation
  #   Given I am not signed in
  #   When I sign up with a mismatched password confirmation
  #   Then I should see a mismatched password message
  scenario 'visitor cannot sign up with mismatched password and confirmation' do
    sign_up_with('test@example.com', 'please123', 'mismatch')
    expect(page).to have_content "Password confirmation doesn't match"
  end

end
