describe Commands::Status do
  let(:car) { double(odometer_reading: :reading) }
  let(:sharer) { :sharer }

  it 'generates a status response' do
    status = Commands::Status.new(car: car, sharer: sharer)

    response = double
    expect(Responses::Status).to receive(:new).with(car: car, sharer: sharer).and_return response
    status.execute

    expect(status.responses).to include(response)
  end
end
