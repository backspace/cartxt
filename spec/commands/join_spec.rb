describe Commands::Join do
  let(:car) { :car }
  let(:sharer) { double }

  it 'saves the sharer' do
    join = Commands::Join.new(car: car, sharer: sharer)

    expect(sharer).to receive(:know!)

    join.execute

    expect(join).to have_response_from_car("To join the car share, please reply with your name.")
  end
end
