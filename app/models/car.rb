class Car < ActiveRecord::Base
  include AASM

  has_many :bookings
  has_many :borrowings

  aasm column: :status do
    state :awaiting_final_report
    state :returned, initial: true

    state :awaiting_initial_report
    state :borrowed

    event :borrow do
      transitions from: :returned, to: :awaiting_initial_report
    end

    event :return do
      transitions from: :borrowed, to: :awaiting_final_report
    end

    event :accept_report do
      transitions from: :awaiting_initial_report, to: :borrowed, on_transition: Proc.new { |obj, *args| obj.update_odometer(args) }
      transitions from: :awaiting_final_report, to: :returned, on_transition: Proc.new { |obj, *args| obj.update_odometer(args) }
      transitions from: :borrowed, to: :borrowed, on_transition: Proc.new { |obj, *args| obj.update_odometer(args) }
    end
  end

  def update_odometer(args)
    new_reading = args.first.to_i
    current_reading = self.odometer_reading || 0
    raise InvalidOdometerReadingException.new("Cannot accept a lower odometer reading.") if current_reading > new_reading
    self.odometer_reading = new_reading
  end

  def next_booking
    bookings.upcoming.first
  end

  def borrowed_by?(sharer)
    # FIXME assumes one current borrowing
    borrowings.incomplete.first.sharer == sharer
  end

  def current_borrowing
    borrowings.incomplete.first
  end
end
