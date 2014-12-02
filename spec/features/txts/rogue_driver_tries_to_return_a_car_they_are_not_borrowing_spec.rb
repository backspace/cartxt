feature "Rogue driver tries to return a car they are not borrowing", :txt do
  let!(:borrower) { create :sharer }
  let!(:rogue) { create :sharer }

  let!(:car) { create :car, :borrowed }
  let!(:borrowing) { create :borrowing, :incomplete, car: car, sharer: borrower }

  scenario "they are rebuffed" do
    expect(rogue.number => "return").to produce_response({rogue.number => "You are not borrowing the car!"})
  end
end
