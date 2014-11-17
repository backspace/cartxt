require 'capybara/poltergeist'

Capybara.javascript_driver = :poltergeist
Capybara.asset_host = 'http://localhost:3000'

Capybara.server_host = Rails.application.config.action_mailer.default_url_options[:host].split(":").first
Capybara.server_port = Rails.application.config.action_mailer.default_url_options[:host].split(":").last.to_i
