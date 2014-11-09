module Commands
  class OdometerReportBorrowing < AbstractCommand
    def initialize(options)
      super
      @reading = options[:reading].to_i
      @original_reading = options[:original_reading].to_i
    end

    def execute
      Borrowing.create(car: car, sharer: sharer, initial: @reading, rate: car.rate)
      @responses.push Responses::OdometerReport.new(car: car, sharer: sharer)
      Sharer.admin.each{|admin| @responses.push Responses::OdometerReportJumpNotification.new(car: car, sharer: admin, borrower: sharer, reading: @reading, original_reading: @original_reading)} if @reading > @original_reading
    end
  end
end
