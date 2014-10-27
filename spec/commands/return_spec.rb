describe Commands::Return do
  let(:sharer) { :sharer }

  context 'when the car is borrowed' do
    let(:car) { double(may_return?: true) }

    it 'sets the car status to returned' do
      return_command = Commands::Return.new(car: car, sharer: sharer)

      expect(car).to receive(:return!)

      return_command.execute

      expect(return_command).to have_response_from_car("Thanks! What is the odometer reading?")
    end
  end

  context 'when the car is returned' do
    let(:car) { double(may_return?: false) }

    it 'rejects the return command' do
      return_command = Commands::Return.new(car: car, sharer: sharer)

      return_command.execute

      expect(return_command).to have_response_from_car("The car has already been returned!")
    end
  end
end
