describe Commands::Name do
  let(:car) { :car }
  let(:sharer) { double(number: :number) }
  let(:new_name) { :new_name }

  it 'names the sharer and requests admin approval' do
    name = Commands::Name.new(car: car, sharer: sharer, name: new_name)

    expect(sharer).to receive(:rename!).with(new_name)

    admin = double(number: :number)
    expect(Sharer).to receive(:admin).and_return [admin]

    expect(Responses::Name).to receive(:new).with(car: car, sharer: sharer).and_return(sharer_response = double)
    expect(Responses::AdminApprovalRequest).to receive(:new).with(car: car, admin: admin, sharer: sharer).and_return(admin_response = double)

    name.execute

    expect(name.responses).to include(sharer_response)
    expect(name.responses).to include(admin_response)
  end
end
