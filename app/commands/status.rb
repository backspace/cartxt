module Commands
  class Status < AbstractCommand
    def initialize(options)
      super
    end

    def execute
      @responses.push Response.new(from: car, to: sharer, body: "The odometer reading is #{car.odometer_reading}")
    end
  end
end
