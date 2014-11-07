module Responses
  class Name < DynamicResponse
    description "Sent when the sender sets their name."

    default_body "Nice to meet you, {{sender.name}}. Please wait while I check in."
  end
end
