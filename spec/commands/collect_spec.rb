describe Commands::Collect do
  let(:car) { :car }
  let(:admin) { double }
  let(:sharer) { double(balance: 10, pending_payments: 5) }

  let(:collection_string) { "2 #SharerNumber" }

  it 'deducts the cost from the pending payments, balance, and responds' do
    collect = Commands::Collect.new(car: car, sharer: admin, collection_string: collection_string)

    expect(Utilities::CurrencyParser).to receive(:new).with("2").and_return(parser = double)
    expect(parser).to receive(:parse).and_return(parsed_cost = 2)

    expect(Sharer).to receive(:find_by).with(number: "#SharerNumber").and_return(sharer)
    expect(sharer).to receive(:balance=).with(sharer.balance - parsed_cost)
    expect(sharer).to receive(:pending_payments=).with(sharer.pending_payments - parsed_cost)
    expect(sharer).to receive(:save)

    expect(Transaction).to receive(:create).with(sharer: sharer, amount: -parsed_cost)

    expect(Responses::Collect).to receive(:new).with(car: car, admin: admin, collectee: sharer, amount: parsed_cost).and_return response = double
    expect(Responses::CollectSharerNotification).to receive(:new).with(car: car, sharer: sharer, amount: parsed_cost).and_return sharer_response = double

    collect.execute

    expect(collect.responses).to include response
    expect(collect.responses).to include sharer_response
  end
end
