module Responses
  class StatusBorrowed < DynamicResponse
    description "Sent in reply to the 'status' command when thecar is being borrowed."

    default_body "Sorry, I am being borrowed."
  end
end
