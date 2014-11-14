module Formatters
  class RelativeTime
    def initialize(time)
      @time = time
    end

    def format
      if today?
        "today (#{time.strftime "%A"}) at #{time.to_formatted_s.split.last}"
      elsif tomorrow?
        "tomorrow (#{time.strftime "%A"}) at #{time.to_formatted_s.split.last}"
      elsif in_the_next_month?
        "#{time.strftime "%A"} the #{time.day.ordinalize} at #{time.to_formatted_s.split.last}"
      else
        time.to_formatted_s.gsub("  ", " ")
      end
    end

    private
    def time
      @time
    end

    def today?
      time.to_date == now.to_date
    end

    def tomorrow?
      time.to_date == (now + 1.day).to_date
    end

    def in_the_next_month?
      time <= (now + 1.month).midnight
    end

    def now
      Time.zone.now
    end
  end
end
