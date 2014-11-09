feature 'Driver logs the odometer reading', :txt do
  before do
    @car = Car.new(number: 'Bot', status: 'borrowed')
    @car.save

    create :sharer
  end

  scenario 'They receive a rejection when the new reading is lower than the current one' do
    @car.odometer_reading = 100
    @car.save

    expect("50").to produce_response "Unable to set odometer reading to 50, which is lower than the current reading of 100"
  end
end
