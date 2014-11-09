describe Commands::OdometerReportReturning do
  let(:car) { double(:car, rate: 0.25) }
  let(:sharer) { double(:sharer, balance: 10) }
  let(:reading) { 100 }

  let(:report) { Commands::OdometerReportReturning.new(car: car, sharer: sharer, reading: reading) }

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
