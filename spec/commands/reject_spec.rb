describe Commands::Reject do
  let(:car) { :car }
  let(:sharer) { double}

  it 'rejects the sharer by number' do
    unapproved_sharer = double(name: :unapproved_name, number: :unapproved_number)

    reject = Commands::Reject.new(car: car, sharer: sharer, unapproved_sharer_number: unapproved_sharer.number)

    expect(Sharer).to receive(:find_by).with(status: 'unapproved', number: unapproved_sharer.number).and_return(unapproved_sharer)

    expect(unapproved_sharer).to receive(:reject!)

    reject.execute

    expect(reject).to have_responses_from_car_to(sharer => "We silently rejected #{unapproved_sharer.name}, at number #{unapproved_sharer.number}.")
  end
end
