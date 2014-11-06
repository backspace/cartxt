describe Commands::Gas do
  let(:car) { :car }
  let(:sharer) { double(pending_payments: 10) }

  let(:cost_string) { double }

  it 'deducts the cost from the balance and responds' do
    gas = Commands::Gas.new(car: car, sharer: sharer, cost_string: cost_string)

    expect(Utilities::CurrencyParser).to receive(:new).with(cost_string).and_return(parser = double)
    expect(parser).to receive(:parse).and_return(parsed_cost = 2)

    expect(sharer).to receive(:pending_payments=).with(sharer.pending_payments + parsed_cost)
    expect(sharer).to receive(:save)

    expect(Responses::Gas).to receive(:new).with(car: car, sharer: sharer, cost: parsed_cost).and_return(response = double)

    gas.execute

    expect(gas.responses).to include(response)
  end
end
