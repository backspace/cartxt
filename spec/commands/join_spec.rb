describe Commands::Join do
  let(:car) { :car }
  let(:sharer) { double }

  it 'saves the sharer' do
    join = Commands::Join.new(car: car, sharer: sharer)

    expect(sharer).to receive(:know!)

    expect(Responses::Join).to receive(:new).with(car: car, sharer: sharer).and_return(response = double)
    join.execute

    expect(join.responses).to include(response)
  end
end
