describe Commands::ForwardRejection do
  let(:car) { :car }
  let(:sharer) { double(name: :name, number: :number) }
  let(:txt) { 'something' }

  it 'alerts the admin to the rejection' do
    forward = Commands::ForwardRejection.new(car: car, sharer: sharer, txt: txt)

    admin = double(number: :number)
    expect(Sharer).to receive(:admin).and_return [admin]

    forward.execute

    expect(forward).to have_responses_from_car_to(admin => "Rejected sharer #{sharer.name} at number #{sharer.number} sent this and we ignored it: #{txt}")
  end
end
