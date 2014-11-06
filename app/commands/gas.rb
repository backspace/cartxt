module Commands
  class Gas < AbstractCommand
    def initialize(options)
      super
      @cost_string = options[:cost_string]
    end

    def execute
      sharer.pending_payments = sharer.pending_payments + parsed_cost
      sharer.save

      @responses.push Responses::Gas.new(car: car, sharer: sharer, cost: parsed_cost)
    end

    private
    def parsed_cost
      @parsed_cost ||= Utilities::CurrencyParser.new(@cost_string).parse
    end
  end
end
