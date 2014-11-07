module Responses
  class ConfirmAdminNotification < DynamicResponse
    expose :booker, presenter: "Sharer"
    expose :booking, presenter: "Booking"

    default_body "{{booker.formatted}}, has booked me {{booking.formatted}}."

    def initialize(options)
      super

      @to = options[:admin]
    end
  end
end
