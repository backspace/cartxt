module Commands
  class Status < AbstractCommand
    def initialize(options)
      super
    end

    def execute
      append_response "The odometer reading is #{car.odometer_reading}"
    end
  end
end
