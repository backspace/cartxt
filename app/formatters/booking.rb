module Formatters
  class Booking
    def initialize(booking)
      @from = booking.begins_at
      @to = booking.ends_at
    end

    def format
      if @from.to_date == @to.to_date
        "from #{@from.to_formatted_s.split.last} to #{@to.to_formatted_s.split.last} on #{format_date(@from)}"
      else
        "from #{@from.to_formatted_s} to #{@to.to_formatted_s}".gsub("  ", " ")
      end
    end

    private
    def format_date(date)
      if date <= Time.now + 1.month
        "#{date.strftime "%A"} the #{date.day.ordinalize}"
      else
        date.to_formatted_s.split.first
      end
    end
  end
end
