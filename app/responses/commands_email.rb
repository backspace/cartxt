module Responses
  class CommandsEmail < DynamicResponse
    description "Describes how to use the email command."

    default_body "email: use \"email address@example.com\" to set your email address to allow you to check your balance online."
  end
end
