class UserMailer < ActionMailer::Base
  # FIXME get from address from ENV
  default from: ENV["SMTP_USERNAME"] || "cartxt@example.com"

  def approved(user)
    @user = user

    mail to: user.email, subject: "[cartxt] You have been approved to use cartxt"
  end
end
