module Commands
  class AbstractCommand
    attr_accessor :car, :sharer, :responses

    def initialize(options = nil)
      @responses = []

      @car = options[:car]
      @sharer = options[:sharer]
    end

    protected
    def append_response_to(to, body)
      @responses.push Response.new(from: car, to: to, body: body)
    end

    def append_response(body)
      append_response_to(sharer, body)
    end
  end
end
