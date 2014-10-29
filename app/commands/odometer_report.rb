module Commands
  class OdometerReport < AbstractCommand
    def initialize(options)
      super

      @reading = options[:reading]
    end

    def execute
      begin
        car.accept_report!(nil, @reading)

        response_body = "Set odometer reading to #{@reading}"

        if car.borrowed?
          Borrowing.create(car: car, sharer: sharer, initial: @reading)
        else
          borrowing = Borrowing.of(car).incomplete.first

          borrowing.final = @reading
          borrowing.save

          response_body << ". Your balance is #{ActionController::Base.helpers.number_to_currency(sharer.balance + car.rate*(@reading.to_i - borrowing.initial))}."
        end

        @responses.push Response.new(from: car, to: sharer, body: response_body)
      rescue InvalidOdometerReadingException
        @responses.push Response.new(from: car, to: sharer, body: "Unable to set odometer reading to #{@reading}, which is lower than the current reading of #{car.odometer_reading}")
      end
    end
  end
end
