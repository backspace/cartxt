describe Commands::Return do
  let(:sharer) { :sharer }

  context 'when the car is borrowed' do
    let(:car) { double(status: 'borrowed') }

    it 'sets the car status to returned' do
      return_command = Commands::Return.new(car: car, sharer: sharer)

      expect(car).to receive(:status=).with 'returned'
      expect(car).to receive(:save)

      return_command.execute

      expect(return_command).to have_response_from_car("Thanks!")
    end
  end

  context 'when the car is returned' do
    let(:car) { double(status: 'returned') }

    it 'rejects the return command' do
      return_command = Commands::Return.new(car: car, sharer: sharer)

      expect(car).to receive(:status).and_return 'returned'

      return_command.execute

      expect(return_command).to have_response_from_car("The car has already been returned!")
    end
  end
end
