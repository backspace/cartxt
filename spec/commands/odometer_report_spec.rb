describe Commands::OdometerReport do
  let(:car) { double }
  let(:sharer) { :sharer }
  let(:reading) { :reading }

  it 'sets the odometer reading and generates a response' do
    report = Commands::OdometerReport.new(car: car, sharer: sharer, reading: reading)

    expect(car).to receive(:odometer_reading=).with(reading)
    expect(car).to receive(:save)

    report.execute

    expect(report.responses.length).to eq(1)
    response = report.responses.first

    expect(response.from).to eq(car)
    expect(response.to).to eq(sharer)
    expect(response.body).to eq("Set odometer reading to #{reading}")
  end
end
