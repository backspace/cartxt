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

      it "delegates to borrowing odometer report" do
        expect(Commands::OdometerReportBorrowing).to receive(:new).with(car: car, sharer: sharer, reading: reading, original_reading: original_reading).and_return(delegate = double)
        expect(delegate).to receive(:execute)
        expect(delegate).to receive(:responses).and_return(responses = double)

        report.execute

        expect(report.responses).to eq(responses)
      end
    end

    context 'when the report is at the end of a borrowing' do
      before do
        expect(car).to receive(:borrowed?).and_return false
      end

      it "delegates to returning odometer report" do
        expect(Commands::OdometerReportReturning).to receive(:new).with(car: car, sharer: sharer, reading: reading).and_return(delegate = double)
        expect(delegate).to receive(:execute)
        expect(delegate).to receive(:responses).and_return(responses = double)

        report.execute

        expect(report.responses).to eq(responses)
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
