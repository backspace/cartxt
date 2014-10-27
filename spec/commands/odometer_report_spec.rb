describe Commands::OdometerReport do
  let(:car) { double }
  let(:sharer) { :sharer }
  let(:reading) { :reading }

  it 'sets the odometer reading and generates a response' do
    report = Commands::OdometerReport.new(car: car, sharer: sharer, reading: reading)

    expect(car).to receive(:odometer_reading=).with(reading)
    expect(car).to receive(:save)

    report.execute

    expect(report).to have_response_from_car("Set odometer reading to #{reading}")
  end
end
