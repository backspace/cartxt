module Responses
  class ConfirmAdminNotification < DynamicResponse
    expose :booker, presenter: "Sharer"
    expose :booking, presenter: "Booking"

    def initialize(options)
      super

      @to = options[:admin]
    end

    def self.default_body
      "{{booker.formatted}}, has booked me {{booking.formatted}}."
    end
  end
end
