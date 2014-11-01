module Formatters
  class Booking
    def initialize(booking)
      @from = booking.begins_at
      @to = booking.ends_at
    end

    def format
      if @from.to_date == @to.to_date
        "from #{@from.to_formatted_s.split.last} to #{@to.to_formatted_s.split.last} on #{@from.to_formatted_s.split.first}"
      else
        "from #{@from.to_formatted_s} to #{@to.to_formatted_s}".gsub("  ", " ")
      end
    end
  end
end
