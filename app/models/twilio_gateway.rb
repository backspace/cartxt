class TwilioGateway
  def initialize(client)
    @client = client
  end

  def deliver(options)
    @client.account.sms.messages.create(
      to: options[:to],
      from: options[:from],
      body: options[:body]
    )
  end
end
