feature "Admin is notified of an unexplained odometer jump", :txt do
  let!(:car) { create(:car, rate: 0, odometer_reading: 100) }
  let!(:sharer) { create :sharer }
  let!(:admin) { create :sharer, :admin }

  let!(:booking) { create :booking, :current, car: car, sharer: sharer }

  scenario "The reading is accepted but the admin is notified" do
    expect(sharer.number => "borrow").to produce_irrelevant_response

    expect(sharer.number => "150").to produce_responses({
      sharer.number => "Updated the records with a reading of 150km. When finished, just say \"return\". If you buy gas, say \"gas 25.50\" or however much you spend, and make sure to save the receipt.",
      admin.number => "#{sharer.name} is borrowing the car and reports the odometer reading is 150 when it was last known to be 100. Hmm."
    })
  end
end
