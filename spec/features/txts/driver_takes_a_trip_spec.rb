feature 'Driver takes a trip', :txt do
  let!(:car) { create(:car, rate: 0.32, location_information: "The car is parked behind 100 Main St.", lockbox_information: "The key is in a lockbox at the top of the fire escape, the combination is 1234.") }
  let!(:sharer) { create :sharer, balance: 0.32 }

  scenario 'They receive their total owing at the end' do
    expect("borrow").to produce_response "How long do you want the car for? Say something like \"until tomorrow at 10AM\" or \"until 1pm\"."

    expect("until tomorrow at 1pm").to produce_response "The car is yours until tomorrow (#{(Time.now + 1.day).strftime("%A")}) at 1:00PM. The current rate is $0.32/km. #{car.location_information} #{car.lockbox_information} What is the odometer reading?"

    expect("0").to produce_response "Updated the records with a reading of 0km. When finished, just say \"return\". If you buy gas, say \"gas 25.50\" or however much you spend, and make sure to save the receipt."

    expect("return").to produce_response "#{car.location_information} #{car.lockbox_information} What is the odometer reading?"

    expect("200").to produce_response "Updated the records with a reading of 200km. You drove 200km. That brings your balance to $64.32."
  end
end
