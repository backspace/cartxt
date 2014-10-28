describe Commands::Borrow do
  let(:sharer) { :sharer }

  context 'when the car is returned' do
    let(:car) { double(may_borrow?: true) }

    it 'sets the car status to borrowed' do
      borrow = Commands::Borrow.new(car: car, sharer: sharer)

      expect(car).to receive(:borrow!)

      next_booking_content = "next booking text "
      next_booking_formatter = double
      expect(NextBookingFormatter).to receive(:new).with(car: car).and_return next_booking_formatter
      expect(next_booking_formatter).to receive(:output).and_return next_booking_content

      borrow.execute

      expect(borrow).to have_response_from_car("The car is yours! #{next_booking_content}What is the odometer reading?")
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
