module Responses
  class CommandsBookings < DynamicResponse
    description "Describes how to use the bookings command."

    default_body "bookings: lists your bookings."
  end
end
