module Responses
  class Name < DynamicResponse
    description "Sent when the sender sets their name."

    def default_body
      "Nice to meet you, {{sender_name}}. Please wait while I check in."
    end
  end
end
