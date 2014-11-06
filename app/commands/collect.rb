module Commands
  class Collect < AbstractCommand
    def initialize(options)
      super
      @collection_string = options[:collection_string]
    end

    def execute
      collectee.balance = collectee.balance - parsed_amount
      collectee.pending_payments = collectee.pending_payments - parsed_amount
      collectee.save

      Transaction.create(sharer: collectee, amount: -parsed_amount)

      @responses.push Responses::Collect.new(car: car, collectee: collectee, admin: sharer, amount: parsed_amount)
      @responses.push Responses::CollectSharerNotification.new(car: car, sharer: collectee, amount: parsed_amount)
    end

    private
    def parsed_amount
      @parsed_amount ||= Utilities::CurrencyParser.new(@collection_string.split.first).parse
    end

    def collectee
      @collectee ||= Sharer.find_by(number: @collection_string.split.last)
    end
  end
end
