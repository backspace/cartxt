module Commands
  class Status < AbstractCommand
    def initialize(options)
      super
    end

    def execute
      @responses.push Responses::Status.new(car: car, sharer: sharer)
    end
  end
end
