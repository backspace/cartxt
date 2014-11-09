feature 'Driver takes a trip', :txt do
  let!(:car) { FactoryGirl.create(:car, rate: 0.32, location_information: "I am parked behind 100 Main St.", lockbox_information: "The key is in a lockbox at the top of the fire escape, the combination is 1234.") }
  let!(:sharer) { FactoryGirl.create :sharer, balance: 0.32 }

  scenario 'They receive their total owing at the end' do
    expect_txt_response "I am yours! My current rate is $0.32/km. #{car.location_information} #{car.lockbox_information} What is my odometer reading?"
    send_txt "borrow"

    expect_txt_response "Thanks, I updated the records with a reading of 0km. When our time together is finished, just say \"return\". If you buy gas, say \"gas 25.50\" or however much you spend, and make sure to save the receipt!"
    send_txt "0"

    expect_txt_response "Thanks for the ride! #{car.location_information} #{car.lockbox_information} What is my odometer reading?"
    send_txt "return"

    expect_txt_response "Thanks, I updated the records with a reading of 200km. Wow, we drove 200km! That brings your balance to $64.32."
    send_txt "200"
  end
end
