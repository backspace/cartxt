describe Commands::Bookings do
  let(:car) { double(:car) }
  let(:sharer) { double(:sharer) }

  it "generates a bookings response with the sharer's bookings" do
    bookings = Commands::Bookings.new(car: car, sharer: sharer)

    expect(sharer).to receive(:bookings).and_return(double(upcoming: sharer_bookings = double))
    expect(Responses::Bookings).to receive(:new).with(car: car, sharer: sharer, bookings: sharer_bookings).and_return response = double
    bookings.execute

    expect(bookings.responses).to include(response)
  end
end
