module Commands
  class OdometerReportReturning < AbstractCommand
    def initialize(options)
      super
      @reading = options[:reading]
    end

    def execute
      borrowing = Borrowing.of(car).incomplete.first

      borrowing.final = @reading
      borrowing.save

      balance_change = borrowing.rate*(borrowing.final - borrowing.initial)
      Transaction.create(origin: borrowing, sharer: sharer, amount: balance_change)

      sharer.balance = sharer.balance + balance_change
      sharer.save

      @responses.push Responses::OdometerReportReturning.new(car: car, sharer: sharer, borrowing: borrowing)
    end
  end
end
