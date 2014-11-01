module Formatters
  class Booking
    def initialize(booking)
      @from = booking.begins_at
      @to = booking.ends_at
    end

    def format
      "from #{@from.to_formatted_s} to #{@to.to_formatted_s}".gsub("  ", " ")
    end
  end
end
