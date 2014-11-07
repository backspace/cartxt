module Responses
  class OdometerReport < DynamicResponse
    expose :borrowing, presenter: "Borrowing"

    def self.default_body
      "Thanks, I updated the records with a reading of {{car.odometer_reading}}km.{% if car.borrowed? %} When our time together is finished, just say \"return\". If you buy gas, say \"gas 25.50\" or however much you spend, and make sure to save the receipt!{% else %} Wow, we drove {{borrowing.span}}km! That brings your balance to {{sender.balance | as_currency }}.{% endif %}"
    end
  end
end
