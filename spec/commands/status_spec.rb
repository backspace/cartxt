describe Commands::Status, :command do
  let(:car) { double(odometer_reading: :reading) }
  let(:sharer) { :sharer }

  it 'generates a status response' do
    response = double
    expect(Responses::Status).to receive(:new).with(car: car, sharer: sharer).and_return response

    expect(responses).to include(response)
  end
end
