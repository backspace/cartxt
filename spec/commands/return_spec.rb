describe Commands::Return do
  let(:sharer) { :sharer }

  context 'when the car is borrowed' do
    let(:car) { double(may_return?: true) }

    it 'sets the car status to returned' do
      return_command = Commands::Return.new(car: car, sharer: sharer)

      expect(car).to receive(:return!)

      expect(Responses::Return).to receive(:new).with(car: car, sharer: sharer).and_return(response = double)

      return_command.execute

      expect(return_command.responses).to include(response)
    end
  end

  context 'when the car is returned' do
    let(:car) { double(may_return?: false) }

    it 'rejects the return command' do
      return_command = Commands::Return.new(car: car, sharer: sharer)

      expect(Responses::ReturnFailure).to receive(:new).with(car: car, sharer: sharer).and_return(response = double)
      return_command.execute

      expect(return_command.responses).to include(response)
    end
  end
end
