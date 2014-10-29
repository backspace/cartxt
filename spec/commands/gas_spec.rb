describe Commands::Gas do
  let(:car) { :car }
  let(:sharer) { double(balance: 10) }

  let(:cost_string) { double }

  it 'deducts the cost from the balance and responds' do
    gas = Commands::Gas.new(car: car, sharer: sharer, cost_string: cost_string)

    expect(cost_string).to receive(:to_f).and_return(parsed_cost = 2)

    expect(sharer).to receive(:balance=).with(sharer.balance - parsed_cost)
    expect(sharer).to receive(:save)

    expect(Responses::Gas).to receive(:new).with(car: car, sharer: sharer, cost: parsed_cost).and_return(response = double)

    gas.execute

    expect(gas.responses).to include(response)
  end
end
