describe Commands::Commands do
  let(:car) { :car }
  let(:sharer) { double(:sharer) }

  let(:command) { Commands::Commands.new(car: car, sharer: sharer) }

  context 'when the sharer is not an admin' do
    before do
      expect(sharer).to receive(:admin?).and_return false
    end

    it 'returns the commands response' do
      expect(Responses::Commands).to receive(:new).with(car: car, sharer: sharer).and_return response = double

      command.execute

      expect(command.responses).to include(response)
    end
  end

  context 'when the sharer is an admin' do
    before do
      expect(sharer).to receive(:admin?).and_return true
    end

    it 'returns the commands and admin commands responses' do
      expect(Responses::Commands).to receive(:new).with(car: car, sharer: sharer).and_return response = double
      expect(Responses::CommandsAdmin).to receive(:new).with(car: car, sharer: sharer).and_return admin_response = double

      command.execute

      expect(command.responses).to include(response)
      expect(command.responses).to include(admin_response)
    end
  end
end
