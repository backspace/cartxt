module Commands
  class AbstractCommand
    attr_accessor :car, :sharer

    def initialize(options = nil)
      @responses = []

      @car = options[:car]
      @sharer = options[:sharer]
    end

    def responses
      @responses
    end
  end
end
