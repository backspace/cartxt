describe Commands::Commands do
  let(:car) { :car }
  let(:sharer) { double(:sharer) }

  let(:command) { Commands::Commands.new(car: car, sharer: sharer, parameter: parameter) }

  context 'with no parameter' do
    let(:parameter) { '' }

    context 'when the sharer is not an admin' do
      before do
        expect(sharer).to receive(:admin?).and_return false
      end

      context 'with no parameter' do
        let(:parameter) { '' }

        it 'returns the commands response' do
          expect(Responses::Commands).to receive(:new).with(car: car, sharer: sharer).and_return response = double

          command.execute

          expect(command.responses).to include(response)
        end
      end
    end

    context 'when the sharer is an admin' do
      before do
        expect(sharer).to receive(:admin?).and_return true
      end

      context 'with no parameter' do
        let(:parameter) { '' }

        it 'returns the commands and admin commands responses' do
          expect(Responses::Commands).to receive(:new).with(car: car, sharer: sharer).and_return response = double
          expect(Responses::CommandsAdmin).to receive(:new).with(car: car, sharer: sharer).and_return admin_response = double

          command.execute

          expect(command.responses).to include(response)
          expect(command.responses).to include(admin_response)
        end
      end
    end
  end

  # FIXME not adding repetitive specs for each command, any way to automate?
  context 'with balance as a parameter' do
    let(:parameter) { 'balance' }

    it 'returns the commands balance response' do
      expect(Responses::CommandsBalance).to receive(:new).with(car: car, sharer: sharer).and_return response = double

      command.execute

      expect(command.responses).to include(response)
    end
  end

  context 'with book as a parameter' do
    let(:parameter) { 'book' }

    it 'returns the commands book response' do
      expect(Responses::CommandsBook).to receive(:new).with(car: car, sharer: sharer).and_return response = double

      command.execute

      expect(command.responses).to include(response)
    end
  end
end
