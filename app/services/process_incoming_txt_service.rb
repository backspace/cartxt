class ProcessIncomingTxtService
  def initialize(txt)
    @txt = txt
  end

  def process
    GatewayRepository.gateway.deliver from: @txt.to, to: @txt.from, body: "Set odometer reading to #{@txt.body}"
  end
end
