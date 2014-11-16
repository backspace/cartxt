class AdminMailer < ActionMailer::Base
  # FIXME from could be different for some servers
  default to: Proc.new { User.admin.pluck(:email) }, from: ENV["SMTP_USERNAME"] || "cartxt@example.com"

  def user_awaits_approval(user)
    @user = user

    mail subject: "[cartxt] New user #{user.email} requires approval" if User.admin.any?
  end
end
