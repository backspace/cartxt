module Responses
  class ConfirmAdminNotification < DynamicResponse
    description "Sent to admins who have requested notification of all bookings."

    expose :booker, presenter: "Sharer"
    expose :booking, presenter: "Booking"

    default_body "{{booker.formatted}}, has booked me {{booking.formatted}}."

    def initialize(options)
      super

      @to = options[:admin]
    end
  end
end
