describe Commands::ForwardRejection do
  let(:car) { :car }
  let(:sharer) { double(name: :name, number: :number) }
  let(:txt) { 'something' }

  it 'alerts the admin to the rejection' do
    forward = Commands::ForwardRejection.new(car: car, sharer: sharer, txt: txt)

    admin = double(number: :number)
    expect(Sharer).to receive(:admin).and_return [admin]

    expect(Responses::ForwardRejection).to receive(:new).with(car: car, admin: admin, rejected_sharer: sharer, rejected_txt: txt).and_return(response = double)

    forward.execute

    expect(forward.responses).to include(response)
  end
end
