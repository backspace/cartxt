module Responses
  class ConfirmAdminNotification < AbstractResponse
    def initialize(options)
      super

      @to = options[:admin]
      @booker = options[:booker]
      @booking = options[:booking]
    end

    def body
      "#{@booker.name}, at number #{@booker.number}, has booked me from #{@booking.begins_at.to_formatted_s} to #{@booking.ends_at.to_formatted_s}."
    end
  end
end
