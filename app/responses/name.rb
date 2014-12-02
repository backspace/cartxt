module Responses
  class Name < DynamicResponse
    description "Sent when the sender sets their name."

    default_body "Thank you, {{sender.name}}. Please wait to be approved."
  end
end
