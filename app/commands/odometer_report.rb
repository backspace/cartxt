module Commands
  class OdometerReport < AbstractCommand
    def initialize(options)
      super

      @reading = options[:reading]
    end

    def execute
      begin
        car.accept_report!(nil, @reading)

        if car.borrowed?
          Borrowing.create(car: car, sharer: sharer, initial: @reading)
          @responses.push Responses::OdometerReport.new(car: car, sharer: sharer)
        else
          borrowing = Borrowing.of(car).incomplete.first

          borrowing.final = @reading
          borrowing.save

          @responses.push Responses::OdometerReport.new(car: car, sharer: sharer, borrowing: borrowing)
        end
      rescue InvalidOdometerReadingException
        @responses.push Responses::OdometerReportFailure.new(car: car, sharer: sharer, reading: @reading)
      end
    end
  end
end
