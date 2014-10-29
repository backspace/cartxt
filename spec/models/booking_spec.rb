describe Booking do
  def to_date(s)
    Time.zone.parse(s)
  end

  context 'detecting overlaps' do
    let!(:existing_booking) { Booking.create(begins_at: to_date("10:00"), ends_at: to_date("11:00")) }

    def overlapping(start, finish)
      Booking.overlapping(start, finish)
    end

    it 'does not detect a booking entirely before the existing booking' do
      expect(overlapping(to_date("09:00"), to_date("09:30"))).to be_empty
    end

    it 'detects an overlap at the beginning of the existing booking' do
      expect(overlapping(to_date("09:30"), to_date("10:30"))).to include(existing_booking)
    end

    it 'detects an overlap spanning the existing booking' do
      expect(overlapping(to_date("09:30"), to_date("11:30"))).to include(existing_booking)
    end

    it 'detects an overlap within the existing booking' do
      expect(overlapping(to_date("10:15"), to_date("10:45"))).to include(existing_booking)
    end

    it 'detects an overlap at the end of the existing booking' do
      expect(overlapping(to_date("10:30"), to_date("11:30"))).to include(existing_booking)
    end

    it 'does not detect a booking entirely after the existing booking' do
      expect(overlapping(to_date("12:00"), to_date("12:30"))).to be_empty
    end
  end
end
