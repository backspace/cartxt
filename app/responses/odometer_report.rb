module Responses
  class OdometerReport < AbstractResponse
    def initialize(options)
      super

      @borrowing = options[:borrowing]
    end

    def body
      body = "Set odometer reading to #{@car.odometer_reading}"

      unless @car.borrowed?
        body << ". Your balance is #{ActionController::Base.helpers.number_to_currency(@sharer.balance)}."
      end

      body
    end
  end
end
