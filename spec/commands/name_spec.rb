describe Commands::Name do
  let(:car) { :car }
  let(:sharer) { double(number: :number) }
  let(:new_name) { :new_name }

  it 'names the sharer and requests admin approval' do
    name = Commands::Name.new(car: car, sharer: sharer, name: new_name)

    expect(sharer).to receive(:rename!).with(new_name)

    admin = double(number: :number)
    expect(Sharer).to receive(:admin).and_return [admin]

    name.execute

    expect(name).to have_responses_from_car_to(sharer => "Nice to meet you, #{new_name}. Please await admin approval.", admin => "#{new_name}, from number #{sharer.number}, would like to join. Reply with \"approve #{sharer.number}\" (or reject).")
  end
end
