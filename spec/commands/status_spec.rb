describe Commands::Status, :command do
  let(:car) { double(returned?: returned) }
  let(:sharer) { :sharer }

  context "when the car is not returned" do
    let(:returned) { false }

    it "generates a StatusBorrowed response" do
      expect(Responses::StatusBorrowed).to receive(:new).with(car: car, sharer: sharer).and_return response = double
      expect(responses).to include(response)
    end
  end

  context "when the car is returned" do
    let(:returned) { true }

    it "generates a StatusAvailable response" do
      expect(Responses::StatusAvailable).to receive(:new).with(car: car, sharer: sharer).and_return response = double
      expect(responses).to include(response)
    end
  end
end
