describe Commands::Who do
  let(:car) { double(:car) }
  let(:sharer) { :sharer }

  it 'generates a who response' do
    who = Commands::Who.new(car: car, sharer: sharer)

    expect(Sharer).to receive(:all).and_return(sharers = double)

    expect(Responses::Who).to receive(:new).with(car: car, sharer: sharer, sharers: sharers).and_return response = double

    who.execute

    expect(who.responses).to include(response)
  end
end
