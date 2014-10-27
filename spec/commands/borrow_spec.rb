describe Commands::Borrow do
  let(:sharer) { :sharer }

  context 'when the car is returned' do
    let(:car) { double(may_borrow?: true) }

    it 'sets the car status to borrowed' do
      borrow = Commands::Borrow.new(car: car, sharer: sharer)

      expect(car).to receive(:borrow!)

      borrow.execute

      expect(borrow).to have_response_from_car("The car is yours!")
    end
  end

  context 'when the car is borrowed' do
    let(:car) { double(may_borrow?: false) }

    it 'rejects the borrow command' do
      borrow = Commands::Borrow.new(car: car, sharer: sharer)

      borrow.execute

      expect(borrow).to have_response_from_car("The car is already being borrowed!")
      end
  end
end
