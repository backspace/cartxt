describe Commands::Borrow do
  let(:sharer) { :sharer }

  context 'when the car is returned' do
    let(:car) { double(status: 'returned') }

    it 'sets the car status to borrowed' do
      borrow = Commands::Borrow.new(car: car, sharer: sharer)

      expect(car).to receive(:status=).with 'borrowed'
      expect(car).to receive(:save)

      borrow.execute

      expect(borrow.responses.length).to eq(1)
      response = borrow.responses.first

      expect(response.from).to eq(car)
      expect(response.to).to eq(sharer)
      expect(response.body).to eq("The car is yours!")
    end
  end

  context 'when the car is borrowed' do
    let(:car) { double(status: 'borrowed') }

    it 'rejects the borrow command' do
      borrow = Commands::Borrow.new(car: car, sharer: sharer)

      expect(car).to receive(:status).and_return 'borrowed'

      borrow.execute

      expect(borrow.responses.length).to eq(1)
      response = borrow.responses.first

      expect(response.from).to eq(car)
      expect(response.to).to eq(sharer)
      expect(response.body).to eq("The car is already being borrowed!")
      end
  end
end
