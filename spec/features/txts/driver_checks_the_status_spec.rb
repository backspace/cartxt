feature 'Driver checks the status', :txt do
  let!(:sharer) { FactoryGirl.create :sharer }

  context 'when the car is being borrowed' do
    let!(:car) { FactoryGirl.create(:car, :borrowed) }

    scenario 'they receive a reply that the car is not available' do
      expect_txt_response "Sorry, I am being borrowed."
      send_txt 'status'
    end
  end

  context 'when the car is returned' do
    let!(:car) { FactoryGirl.create(:car) }

    scenario 'they receive a reply that the car is available' do
      expect_txt_response "I am available to borrow!"
      send_txt 'status'
    end
  end
end
