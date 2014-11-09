module Commands
  class AbstractCommand
    attr_accessor :car, :sharer, :responses

    def initialize(options = nil)
      @responses = []

      @car = options[:car]
      @sharer = options[:sharer]
    end
  end
end
