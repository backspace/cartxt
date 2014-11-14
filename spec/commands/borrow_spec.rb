describe Commands::Borrow do
  let(:sharer) { :sharer }

  context 'when the car is returned' do
    let(:car) { double(may_borrow?: true, rate: 'X') }

    context "when the sharer has a current booking" do
      let(:booking) { double :booking }
      before do
        expect(Booking).to receive(:has_current_booking?).with(car: car, sharer: sharer).and_return booking
      end

      it 'creates a borrowing and sets the car status to borrowed' do
        borrow = Commands::Borrow.new(car: car, sharer: sharer)

        expect(car).to receive(:borrow!)

        expect(Borrowing).to receive(:create).with(car: car, sharer: sharer, rate: car.rate, booking: booking)

        expect(Responses::Borrow).to receive(:new).with(car: car, sharer: sharer, booking: booking).and_return(response = double)
        borrow.execute

        expect(borrow.responses).to include(response)
      end
    end

    context "when the sharer does not have a current booking" do
      before do
        expect(Booking).to receive(:has_current_booking?).with(car: car, sharer: sharer).and_return false
      end

      it "responds with an ad-hoc booking request" do
        borrow = Commands::Borrow.new(car: car, sharer: sharer)

        expect(Responses::BorrowAdHoc).to receive(:new).with(car: car, sharer: sharer).and_return response = double

        borrow.execute

        expect(borrow.responses).to include(response)
      end
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
