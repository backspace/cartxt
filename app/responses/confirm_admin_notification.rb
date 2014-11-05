module Responses
  class ConfirmAdminNotification < DynamicResponse
    expose :booker, class: Presenters::Sharer
    expose :booking, class: Presenters::Booking

    def initialize(options)
      super

      @to = options[:admin]
    end

    def self.default_body
      "{{booker.formatted}}, has booked me {{booking.formatted}}."
    end
  end
end
