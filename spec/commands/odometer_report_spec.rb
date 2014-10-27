describe Commands::OdometerReport do
  let(:original_reading) { :original_reading }
  let(:car) { double(odometer_reading: original_reading) }
  let(:sharer) { :sharer }
  let(:reading) { :reading }

  it 'sets the odometer reading and generates a response' do
    report = Commands::OdometerReport.new(car: car, sharer: sharer, reading: reading)

    expect(car).to receive(:accept_report!).with(nil, reading)

    report.execute

    expect(report).to have_response_from_car("Set odometer reading to #{reading}")
  end

  it 'rejects a lower odometer reading' do
    report = Commands::OdometerReport.new(car: car, sharer: sharer, reading: reading)

    expect(car).to receive(:accept_report!).with(nil, reading).and_raise InvalidOdometerReadingException

    report.execute

    expect(report).to have_response_from_car("Unable to set odometer reading to #{reading}, which is lower than the current reading of #{original_reading}")
  end
end
