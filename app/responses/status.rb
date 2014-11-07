module Responses
  class Status < DynamicResponse
    description "Sent in reply to the 'status' command."

    default_body "{% if car.returned? %}I am available to borrow!{% else %}Sorry, I am being borrowed.{% endif %}"
  end
end
