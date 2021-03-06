class ProcessIncomingTxtService
  def initialize(txt, gateway = NullGateway.new, context = {})
    @txt = txt
    @gateway = gateway
    @context = context
  end

  def process
    @gateway.deliver_original_copies(@txt)

    parser = Parsers::Command.new(@txt, @context)
    command = parser.parse

    command.execute

    command.responses.each do |response|
      outgoing_txt = Txt.new(from: number_for(response.from), to: number_for(response.to), body: response.body, originator: @txt)
      outgoing_txt.save
      @gateway.deliver from: outgoing_txt.from, to: outgoing_txt.to, body: outgoing_txt.body
    end
  end

  private
  def number_for(participant)
    participant.number
  end
end
