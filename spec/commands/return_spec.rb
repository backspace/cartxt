describe Commands::Return do
  let(:sharer) { :sharer }

  context 'when the car is borrowed' do
    let(:car) { double(may_return?: true) }

    context 'when the borrower is the sharer' do
      before do
        expect(car).to receive(:borrowed_by?).with(sharer).and_return true
      end

      it 'sets the car status to returned' do
        return_command = Commands::Return.new(car: car, sharer: sharer)

        expect(car).to receive(:return!)

        expect(Responses::Return).to receive(:new).with(car: car, sharer: sharer).and_return(response = double)

        return_command.execute

        expect(return_command.responses).to include(response)
      end
    end

    context 'when the borrower is not the sharer' do
      before do
        expect(car).to receive(:borrowed_by?).with(sharer).and_return false
      end

      it "responds with a return failure" do
        return_command = Commands::Return.new(car: car, sharer: sharer)

        expect(Responses::ReturnNotBorrowerFailure).to receive(:new).with(car: car, sharer: sharer).and_return(response = double)
        return_command.execute

        expect(return_command.responses).to include(response)
      end
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
