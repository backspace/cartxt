describe Commands::Reject do
  let(:car) { :car }
  let(:sharer) { double}

  it 'rejects the sharer by number' do
    unapproved_sharer = double(name: :unapproved_name, number: :unapproved_number)

    reject = Commands::Reject.new(car: car, sharer: sharer, unapproved_sharer_number: unapproved_sharer.number)

    expect(Sharer).to receive(:find_by).with(status: 'unapproved', number: unapproved_sharer.number).and_return(unapproved_sharer)

    expect(unapproved_sharer).to receive(:reject!)

    expect(Responses::Reject).to receive(:new).with(car: car, admin: sharer, rejectee: unapproved_sharer).and_return(response = double)

    reject.execute

    expect(reject.responses).to include(response)
  end
end
