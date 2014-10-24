class ProcessIncomingTxtService
  def initialize(txt)
    @txt = txt
  end

  def process
    if @txt.body == 'status'
      GatewayRepository.gateway.deliver from: @txt.to, to: @txt.from, body: "The odometer reading is #{Car.first.odometer_reading}"
    else
      GatewayRepository.gateway.deliver from: @txt.to, to: @txt.from, body: "Set odometer reading to #{@txt.body}"
    end
  end
end
