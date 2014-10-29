module Responses
  class AbstractResponse
    attr_reader :from, :to

    def initialize(options)
      @car = options[:car]
      @sharer = options[:sharer]

      @from = @car
      @to = @sharer
    end
  end
end
