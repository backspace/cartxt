describe Commands::Email do
  let(:car) { :car }
  let(:sharer) { double(:sharer) }
  let(:address) { :address }

  it "sets the sharer's email and responds" do
    email = Commands::Email.new(car: car, sharer: sharer, address: address)

    expect(sharer).to receive(:email=).with(address)
    expect(sharer).to receive(:save)

    expect(Responses::Email).to receive(:new).with(car: car, sharer: sharer).and_return(response = double)

    email.execute

    expect(email.responses).to include(response)
  end
end
