module Commands
  class Join < AbstractCommand
    def initialize(options)
      super
    end

    def execute
      sharer.know!

      append_response "To join the car share, please reply with your name."
    end
  end
end
