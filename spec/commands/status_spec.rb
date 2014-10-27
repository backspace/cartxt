describe Commands::Status do
  let(:car) { double(odometer_reading: :reading) }
  let(:sharer) { :sharer }

  it 'generates a status response' do
    status = Commands::Status.new(car: car, sharer: sharer)
    status.execute

    expect(status).to have_response_from_car("The odometer reading is #{:reading}")
  end
end
