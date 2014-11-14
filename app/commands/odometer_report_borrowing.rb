module Commands
  class OdometerReportBorrowing < AbstractCommand
    def initialize(options)
      super
      @reading = options[:reading].to_i
      @original_reading = options[:original_reading].to_i
    end

    def execute
      borrowing = car.current_borrowing
      borrowing.initial = @reading
      borrowing.save

      @responses.push Responses::OdometerReportBorrowing.new(car: car, sharer: sharer)
      Sharer.admin.each{|admin| @responses.push Responses::OdometerReportJumpNotification.new(car: car, sharer: admin, borrower: sharer, reading: @reading, original_reading: @original_reading)} if @reading > @original_reading
    end
  end
end
