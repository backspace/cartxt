describe Commands::Return do
  let(:car) { double }
  let(:sharer) { :sharer }

  it 'sets the car status to returned' do
    return_command = Commands::Return.new(car: car, sharer: sharer)

    expect(car).to receive(:status=).with 'returned'
    expect(car).to receive(:save)

    return_command.execute

    expect(return_command.responses.length).to eq(1)
    response = return_command.responses.first

    expect(response.from).to eq(car)
    expect(response.to).to eq(sharer)
    expect(response.body).to eq("Thanks!")
  end
end
