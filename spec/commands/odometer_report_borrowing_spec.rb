describe Commands::OdometerReportBorrowing do
  let(:car) { double(:car, rate: 0.25) }
  let(:sharer) { double(:sharer, balance: 10) }
  let(:reading) { 100 }

  let(:report) { Commands::OdometerReportBorrowing.new(car: car, sharer: sharer, reading: reading, original_reading: original_reading) }

  context "when the reading is higher than the previous reading" do
    let(:original_reading) { reading - 50 }

    it 'notifies the admin, sets the odometer reading, creates a borrowing, and generates a response' do
      expect(Borrowing).to receive(:create).with(car: car, sharer: sharer, initial: reading, rate: car.rate)

      expect(Responses::OdometerReportBorrowing).to receive(:new).with(car: car, sharer: sharer).and_return(response = double)

      expect(Sharer).to receive(:admin).and_return([admin = double])
      expect(Responses::OdometerReportJumpNotification).to receive(:new).with(car: car, sharer: admin, borrower: sharer, reading: reading, original_reading: original_reading).and_return(jump_response = double)

      report.execute

      expect(report.responses).to include(response)
      expect(report.responses).to include(jump_response)
    end
  end

  context "when the reading is the same than the previous reading" do
    let(:original_reading) { reading }

    it 'sets the odometer reading, creates a borrowing, and generates a response' do
      expect(Borrowing).to receive(:create).with(car: car, sharer: sharer, initial: reading, rate: car.rate)

      expect(Responses::OdometerReportBorrowing).to receive(:new).with(car: car, sharer: sharer).and_return(response = double)

      report.execute

      expect(report.responses).to include(response)
    end
  end
end
