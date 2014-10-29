module Commands
  class Gas < AbstractCommand
    def initialize(options)
      super
      @cost_string = options[:cost_string]
    end

    def execute
      sharer.balance = sharer.balance - parsed_cost
      sharer.save

      @responses.push Responses::Gas.new(car: car, sharer: sharer, cost: parsed_cost)
    end

    private
    def parsed_cost
      @parsed_cost ||= @cost_string.to_f
    end
  end
end
