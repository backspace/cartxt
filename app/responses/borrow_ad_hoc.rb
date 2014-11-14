module Responses
  class BorrowAdHoc < DynamicResponse
    description "Sent when the sharer borrows without a booking"

    default_body "Yay! How long do you want me for? Say something like \"until tomorrow at 10AM\" or \"until 1pm\"."
  end
end
