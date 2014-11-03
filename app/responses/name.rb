module Responses
  class Name < DynamicResponse
    def default_body
      "Nice to meet you, {{sender_name}}. Please wait while I check in."
    end
  end
end
