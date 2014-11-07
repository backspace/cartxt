module Responses
  class CommandsPay < DynamicResponse
    description "Describers how to use the pay command."

    default_body "pay: to register and submit a payment, send \"pay 13.50\" or however much you submit. Place your payment with the key and it will be subtracted from your balance owing when it is collected."
  end
end
