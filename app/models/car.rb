class Car < ActiveRecord::Base
  include AASM

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
    reading = args.first
    self.odometer_reading = reading
  end
end
