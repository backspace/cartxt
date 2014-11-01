module Responses
  class ConfirmAdminNotification < AbstractResponse
    def initialize(options)
      super

      @to = options[:admin]
      @booker = options[:booker]
      @booking = options[:booking]
    end

    def body
      "#{Formatters::Sharer.new(@booker).format}, has booked me #{Formatters::Booking.new(@booking).format}."
    end
  end
end
