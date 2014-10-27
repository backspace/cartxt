describe Commands::Borrow do
  let(:car) { double }
  let(:sharer) { :sharer }

  it 'sets the car status to borrowed' do
    borrow = Commands::Borrow.new(car: car, sharer: sharer)

    expect(car).to receive(:status=).with 'borrowed'
    expect(car).to receive(:save)

    borrow.execute

    expect(borrow.responses.length).to eq(1)
    response = borrow.responses.first

    expect(response.from).to eq(car)
    expect(response.to).to eq(sharer)
    expect(response.body).to eq("The car is yours!")
  end
end
