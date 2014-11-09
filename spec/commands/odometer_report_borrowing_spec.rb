describe Commands::OdometerReportBorrowing do
  let(:car) { double(:car, rate: 0.25) }
  let(:sharer) { double(:sharer, balance: 10) }
  let(:reading) { 100 }

  let(:report) { Commands::OdometerReportBorrowing.new(car: car, sharer: sharer, reading: reading) }

  it 'sets the odometer reading, creates a borrowing, and generates a response' do
    expect(Borrowing).to receive(:create).with(car: car, sharer: sharer, initial: reading, rate: car.rate)

    expect(Responses::OdometerReport).to receive(:new).with(car: car, sharer: sharer).and_return(response = double)

    report.execute

    expect(report.responses).to include(response)
  end
end
