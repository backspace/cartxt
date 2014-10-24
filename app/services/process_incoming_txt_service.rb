class ProcessIncomingTxtService
  def initialize(txt)
    @txt = txt
  end

  def process
    if @txt.body == 'status'
      GatewayRepository.gateway.deliver from: @txt.to, to: @txt.from, body: "The odometer reading is #{Car.first.odometer_reading}"
    else
      car = Car.first
      car.odometer_reading = @txt.body
      car.save

      GatewayRepository.gateway.deliver from: @txt.to, to: @txt.from, body: "Set odometer reading to #{car.odometer_reading}"
    end
  end
end
