describe Commands::Status do
  let(:car) { double(odometer_reading: :reading) }
  let(:sharer) { :sharer }

  it 'generates a status response' do
    status = Commands::Status.new(car: car, sharer: sharer)
    status.execute

    expect(status.responses.length).to eq(1)
    response = status.responses.first

    expect(response.from).to eq(car)
    expect(response.to).to eq(sharer)
    expect(response.body).to eq("The odometer reading is #{:reading}")
  end
end
