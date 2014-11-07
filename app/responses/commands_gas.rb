module Responses
  class CommandsGas < DynamicResponse
    default_body "gas: when you are borrowing the car and need to buy gas, send \"gas 15.50\" or however much you buy. Submit the receipt when you return the key and the gas will be subtracted from your balance owing."
  end
end
