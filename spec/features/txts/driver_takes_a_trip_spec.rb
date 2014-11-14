feature 'Driver takes a trip', :txt do
  let!(:car) { create(:car, rate: 0.32, location_information: "I am parked behind 100 Main St.", lockbox_information: "The key is in a lockbox at the top of the fire escape, the combination is 1234.") }
  let!(:sharer) { create :sharer, balance: 0.32 }

  scenario 'They receive their total owing at the end' do
    expect("borrow").to produce_response "Yay! How long do you want me for? Say something like \"until tomorrow at 10AM\" or \"until 1pm\"."

    expect("until tomorrow at 1pm").to produce_response "I am yours until tomorrow (#{(Time.now + 1.day).strftime("%A")}) at 1:00PM. My current rate is $0.32/km. #{car.location_information} #{car.lockbox_information} What is my odometer reading?"

    expect("0").to produce_response "Thanks, I updated the records with a reading of 0km. When our time together is finished, just say \"return\". If you buy gas, say \"gas 25.50\" or however much you spend, and make sure to save the receipt!"

    expect("return").to produce_response "Thanks for the ride! #{car.location_information} #{car.lockbox_information} What is my odometer reading?"

    expect("200").to produce_response "Thanks, I updated the records with a reading of 200km. Wow, we drove 200km! That brings your balance to $64.32."
  end
end
