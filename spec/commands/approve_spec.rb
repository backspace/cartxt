describe Commands::Approve do
  let(:car) { :car }
  let(:sharer) { double }

  it 'approves unapproved sharers' do
    unapproved_sharer = double(name: :unapproved_name, number: :unapproved_number)

    approve = Commands::Approve.new(car: car, sharer: sharer, unapproved_sharer_number: unapproved_sharer.number)

    expect(Sharer).to receive(:find_by).with(status: 'unapproved', number: unapproved_sharer.number).and_return(unapproved_sharer)

    expect(unapproved_sharer).to receive(:approve!)

    approve.execute

    expect(approve).to have_responses_from_car_to(unapproved_sharer => "You were approved by an admin! Welcome to the car share.", sharer => "I have welcomed #{unapproved_sharer.name} to the car share.")
  end
end

