class TwilioGateway
  def initialize(client)
    @client = client
  end

  def deliver(options)
    @client.account.messages.create(
      to: options[:to],
      from: options[:from],
      body: options[:body]
    )

    # FIXME improperly placed
    Sharer.receive_copies.each do |sharer|
      if options[:to] != sharer.number
        @client.account.messages.create(
          to: sharer.number,
          from: options[:from],
          body: "To #{options[:to]}:\n\n#{options[:body]}"
        )
      end
    end
  end
end
