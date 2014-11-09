module Commands
  class OdometerReportBorrowing < AbstractCommand
    def initialize(options)
      super
      @reading = options[:reading]
    end

    def execute
      Borrowing.create(car: car, sharer: sharer, initial: @reading, rate: car.rate)
      @responses.push Responses::OdometerReport.new(car: car, sharer: sharer)
    end
  end
end
