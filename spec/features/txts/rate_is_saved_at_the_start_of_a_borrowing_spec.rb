feature "Rate is saved at the beginning of a borrowing", :txt do
  let!(:car) { create(:car, rate: 0.1) }
  let!(:sharer) { create :sharer }

  scenario "The borrowing is isolated from the rate change" do
    expect("borrow").to produce_response "I am yours! My current rate is $0.10/km. What is my odometer reading?"

    # FIXME should be able to ignore responses
    expect("0").to produce_response "Thanks, I updated the records with a reading of 0km. When our time together is finished, just say \"return\". If you buy gas, say \"gas 25.50\" or however much you spend, and make sure to save the receipt!"

    car.rate = 0.2
    car.save

    expect("return").to produce_response "Thanks for the ride! What is my odometer reading?"
    expect("10").to produce_response "Thanks, I updated the records with a reading of 10km. Wow, we drove 10km! That brings your balance to $1.00."
  end
end
