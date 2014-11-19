class AdminMailer < ActionMailer::Base
  default to: Proc.new { User.admin.pluck(:email) }, from: ENV["EMAIL_SENDER"] || "cartxt@example.com"

  def user_awaits_approval(user)
    @user = user
    @url = users_url

    mail subject: "[cartxt] New user #{user.email} requires approval" if User.admin.any?
  end
end
