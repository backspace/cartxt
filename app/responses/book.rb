module Responses
  class Book < DynamicResponse
    expose :booking, presenter: "Booking"

    def self.default_body
      "You wish to book me {{booking.formatted}}? Reply with 'confirm', try another 'book from X to Y', or 'cancel'."
    end
  end
end
