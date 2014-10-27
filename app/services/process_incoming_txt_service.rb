class ProcessIncomingTxtService
  def initialize(txt)
    @txt = txt
  end

  def process
    parser = Commands::Parser.new(@txt)
    command = parser.parse

    command.execute

    command.responses.each do |response|
      GatewayRepository.gateway.deliver from: number_for(response.from), to: number_for(response.to), body: response.body
    end
  end

  private
  def number_for(participant)
    participant.number
  end
end
