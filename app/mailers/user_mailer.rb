class UserMailer < ActionMailer::Base
  default from: ENV["EMAIL_SENDER"] || "cartxt@example.com"

  def approved(user)
    @user = user

    mail to: user.email, subject: "[cartxt] You have been approved to use cartxt"
  end
end
