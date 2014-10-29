describe Commands::Borrow do
  let(:sharer) { :sharer }

  context 'when the car is returned' do
    let(:car) { double(may_borrow?: true) }

    it 'sets the car status to borrowed' do
      borrow = Commands::Borrow.new(car: car, sharer: sharer)

      expect(car).to receive(:borrow!)

      expect(Responses::Borrow).to receive(:new).with(car: car, sharer: sharer).and_return(response = double)
      borrow.execute

      expect(borrow.responses).to include(response)
    end
  end

  context 'when the car is borrowed' do
    let(:car) { double(may_borrow?: false) }

    it 'rejects the borrow command' do
      borrow = Commands::Borrow.new(car: car, sharer: sharer)

      expect(Responses::BorrowFailure).to receive(:new).with(car: car, sharer: sharer).and_return(response = double)

      borrow.execute

      expect(borrow.responses).to include(response)
      end
  end
end
