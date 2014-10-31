module Responses
  class Book < AbstractResponse
    def initialize(options)
      @from = options[:car]
      @to = options[:sharer]
      @booking = options[:booking]
    end

    def body
      "You wish to book me from #{@booking.begins_at.to_formatted_s} to #{@booking.ends_at.to_formatted_s}? Reply with 'confirm', try another 'book from X to Y', or 'cancel'."
    end
  end
end
