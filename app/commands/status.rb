module Commands
  class Status < AbstractCommand
    def initialize(options)
      super
    end

    def execute
      if car.returned?
        @responses.push Responses::StatusAvailable.new(car: car, sharer: sharer)
      else
        @responses.push Responses::StatusBorrowed.new(car: car, sharer: sharer)
      end
    end
  end
end
