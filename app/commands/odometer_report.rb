module Commands
  class OdometerReport < AbstractCommand
    def initialize(options)
      super

      @reading = options[:reading]
    end

    def execute
      @car.accept_report!(nil, @reading)

      @responses.push Response.new(from: @car, to: @sharer, body: "Set odometer reading to #{@reading}")
    end
  end
end
