describe Commands::Balance do
  let(:car) { :car }
  let(:sharer) { double(balance: 23.45) }

  it 'generates a balance response' do
    balance = Commands::Balance.new(car: car, sharer: sharer)

    response = double
    expect(Responses::Balance).to receive(:new).with(car: car, sharer: sharer).and_return response

    balance.execute

    expect(balance.responses).to include(response)
  end
end
