module Responses
  class OdometerReport < AbstractResponse
    def initialize(options)
      super

      @borrowing = options[:borrowing]
    end

    def body
      body = "Thanks, I updated the records with a reading of #{@car.odometer_reading}km."

      unless @car.borrowed?
        body << " Wow, we drove #{@borrowing.span}km! That brings your balance to #{ActionController::Base.helpers.number_to_currency(@sharer.balance)}."
      end

      body
    end
  end
end
