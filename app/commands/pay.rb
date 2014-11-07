module Commands
  class Pay < AbstractCommand
    def initialize(options)
      super
      @amount_string = options[:amount_string]
    end

    def execute
      sharer.pending_payments = sharer.pending_payments + parsed_amount
      sharer.save

      @responses.push Responses::Pay.new(car: car, sharer: sharer, amount: parsed_amount)
      Sharer.admin.each do |admin|
        @responses.push Responses::PayAdminNotification.new(car: car, admin: admin, sharer: sharer, amount: parsed_amount)
      end
    end

    private
    def parsed_amount
      @parsed_amount ||= Parsers::Currency.new(@amount_string).parse
    end
  end
end
