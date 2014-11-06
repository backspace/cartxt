describe Commands::OdometerReport do
  let(:original_reading) { :original_reading }
  let(:car) { double(odometer_reading: original_reading, rate: 0.25) }
  let(:sharer) { double(balance: 10) }
  let(:reading) { 100 }

  context 'with a valid reading' do
    let(:report) { Commands::OdometerReport.new(car: car, sharer: sharer, reading: reading) }

    before do
      expect(car).to receive(:accept_report!).with(nil, reading)
    end

    context 'when the report is at the beginning of a borrowing' do
      before do
        expect(car).to receive(:borrowed?).and_return(true)
      end

      it 'sets the odometer reading, creates a borrowing, and generates a response' do
        expect(Borrowing).to receive(:create).with(car: car, sharer: sharer, initial: reading, rate: car.rate)

        expect(Responses::OdometerReport).to receive(:new).with(car: car, sharer: sharer).and_return(response = double)

        report.execute

        expect(report.responses).to include(response)
      end
    end

    context 'when the report is at the end of a borrowing' do
      before do
        expect(car).to receive(:borrowed?).and_return false
      end

      it 'sets the odometer reading, completes the borrowing, updates the sharer balance, and generates a response' do
        borrowings = double
        borrowing = double(initial: 0, rate: car.rate)
        expect(Borrowing).to receive(:of).with(car).and_return borrowings
        expect(borrowings).to receive(:incomplete).and_return [borrowing]

        expect(borrowing).to receive(:final=).with(reading)
        expect(borrowing).to receive(:save)

        expect(borrowing).to receive(:final).and_return(reading)

        balance_change = borrowing.rate*(reading - borrowing.initial)
        expect(Transaction).to receive(:create).with(amount: balance_change, origin: borrowing, sharer: sharer)

        expect(sharer).to receive(:balance=).with(sharer.balance + balance_change)
        expect(sharer).to receive(:save)

        expect(Responses::OdometerReport).to receive(:new).with(car: car, sharer: sharer, borrowing: borrowing).and_return(response = double)

        report.execute

        expect(report.responses).to include(response)
      end
    end
  end

  it 'rejects a lower odometer reading' do
    report = Commands::OdometerReport.new(car: car, sharer: sharer, reading: reading)

    expect(car).to receive(:accept_report!).with(nil, reading).and_raise InvalidOdometerReadingException

    expect(Responses::OdometerReportFailure).to receive(:new).with(car: car, sharer: sharer, reading: reading).and_return(response = double)

    report.execute

    expect(report.responses).to include(response)
  end
end
