module Parsers
  class BookingIndex
    def initialize(string)
      @string = string
    end

    def parse
      if @string.present?
        @string.gsub("#", "").to_i - 1
      else
        nil
      end
    end
  end
end
