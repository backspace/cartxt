class TwilioGateway
  def initialize(client)
    @client = client
  end

  def deliver(options)
    deliver_without_copies(options)
    deliver_copies(options)
  end

  # FIXME should be included in ProcessIncomingTxtService?
  def deliver_original_copies(txt)
    Sharer.receive_copies.each do |sharer|
      if txt.from != sharer.number
        @client.account.messages.create(
          to: sharer.number,
          from: txt.to,
          body: "From #{txt.from}:\n\n#{txt.body}"
        )
      end
    end
  end

  private
  def deliver_without_copies(options)
    @client.account.messages.create(
      to: options[:to],
      from: options[:from],
      body: options[:body]
    )
  end

  def deliver_copies(options)
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
