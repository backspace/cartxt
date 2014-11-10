module Responses
  class Email < DynamicResponse
    description "Sent when a sharer sets their email address."

    default_body "I recorded your email address as {{sender.email}}. You can now check your balance on the site."
  end
end
