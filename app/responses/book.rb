module Responses
  class Book < AbstractResponse
    def initialize(options)
      @from = options[:car]
      @to = options[:sharer]
      @booking = options[:booking]
    end

    def body
      "You have booked the car from #{@booking.begins_at.to_formatted_s} to #{@booking.ends_at.to_formatted_s}."
    end
  end
end
