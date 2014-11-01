module Formatters
  class Sharer
    def initialize(sharer)
      @sharer = sharer
    end

    def format
      "#{@sharer.name} #{@sharer.number}"
    end
  end
end
