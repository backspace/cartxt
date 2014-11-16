feature 'Driver checks the status', :txt do
  before do
    Timecop.freeze(Time.local(2014, 11, 16, 17, 0, 0))
  end

  after do
    Timecop.return
  end

  let!(:sharer) { create :sharer }

  context 'when the car is being borrowed' do
    let!(:car) { create(:car, :borrowed) }

    let!(:begins_at) { Time.zone.parse("2014-11-17 10AM") }
    let!(:ends_at) { begins_at + 2.hours }

    let!(:booking) { create :booking, car: car, begins_at: begins_at, ends_at: ends_at }
    let!(:borrowing) { create :borrowing, :incomplete, car: car, booking: booking }

    scenario 'they receive a reply that the car is not available' do
      expect("status").to produce_response "Sorry, I am booked until #{Formatters::RelativeTime.new(ends_at).format}."
    end
  end

  context 'when the car is returned' do
    let!(:car) { create(:car) }

    context "and there is an upcoming booking" do
      let(:begins_at) { Time.zone.parse("2014-11-17 10AM") }
      let(:ends_at) { begins_at + 2.hours }

      let!(:booking) { create :booking, car: car, begins_at: begins_at, ends_at: ends_at }

      scenario "they receive a reply that the car is available until the next booking" do
        expect("status").to produce_response "I am available to borrow! My next booking begins tomorrow (Monday) at 10:00AM."
      end
    end

    scenario 'they receive a reply that the car is available' do
      expect("status").to produce_response "I am available to borrow!"
    end
  end
end
