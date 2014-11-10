module Responses
  class CommandsBookings < DynamicResponse
    description "Describes how to use the bookings command."

    default_body "bookings: lists your bookings. You can abandon them by number with the abandon command."
  end
end
