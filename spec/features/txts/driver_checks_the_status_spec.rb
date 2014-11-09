feature 'Driver checks the status', :txt do
  let!(:sharer) { create :sharer }

  context 'when the car is being borrowed' do
    let!(:car) { create(:car, :borrowed) }

    scenario 'they receive a reply that the car is not available' do
      expect("status").to produce_response "Sorry, I am being borrowed."
    end
  end

  context 'when the car is returned' do
    let!(:car) { create(:car) }

    scenario 'they receive a reply that the car is available' do
      expect("status").to produce_response "I am available to borrow!"
    end
  end
end
