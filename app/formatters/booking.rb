module Formatters
  class Booking
    def initialize(booking)
      @from = booking.begins_at
      @to = booking.ends_at
    end

    def format
      if in_the_past?
        format_in_the_past
      elsif within_a_day?
        if in_the_next_day?
          if not_today?
            format_tomorrow
          else
            format_today
          end
        else
          format_in_the_next_month
        end
      else
        format_in_the_future
      end
    end

    protected
    def format_tomorrow
      "tomorrow (#{@from.strftime "%A"}) from #{@from.to_formatted_s.split.last} to #{@to.to_formatted_s.split.last}"
    end

    def format_today
      "today (#{@from.strftime "%A"}) from #{@from.to_formatted_s.split.last} to #{@to.to_formatted_s.split.last}"
    end

    def format_in_the_next_month
      "from #{@from.to_formatted_s.split.last} to #{@to.to_formatted_s.split.last} on #{format_date(@from)}"
    end

    def format_in_the_future
      "from #{@from.to_formatted_s} to #{@to.to_formatted_s}".gsub("  ", " ")
    end

    def format_in_the_past
      format_in_the_future
    end

    private
    def format_date(date)
      if date <= Time.now + 1.month
        "#{date.strftime "%A"} the #{date.day.ordinalize}"
      else
        date.to_formatted_s.split.first
      end
    end

    def within_a_day?
      @from.to_date == @to.to_date
    end

    def in_the_next_day?
      @from <= (Time.zone.now + 2.days).midnight
    end

    def not_today?
      @from.day != Time.zone.now.day
    end

    def in_the_past?
      @from < Time.zone.now
    end
  end
end
