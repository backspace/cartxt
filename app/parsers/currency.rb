module Parsers
  class Currency
    def initialize(string)
      @string = string
    end

    def parse
      @string.gsub("$", "").to_f
    end
  end
end
