module Commands
  class Join < AbstractCommand
    def initialize(options)
      super
    end

    def execute
      sharer.know!

      @responses.push Responses::Join.new(car: car, sharer: sharer)
    end
  end
end
