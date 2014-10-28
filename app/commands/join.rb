module Commands
  class Join < AbstractCommand
    def initialize(options)
      super
    end

    def execute
      sharer.know!

      @responses.push Response.new(from: car, to: sharer, body: "To join the car share, please reply with your name.")
    end
  end
end
