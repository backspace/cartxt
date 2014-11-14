class Booking < ActiveRecord::Base
  belongs_to :car
  belongs_to :sharer

  default_scope { order("begins_at") }
  scope :upcoming, -> { where("begins_at > ?", Time.now) }
  scope :overlapping, ->(start, finish) { where.not("ends_at < ? OR begins_at > ?", start, finish) }
  scope :unconfirmed_for, ->(car, sharer) { where(car: car, sharer: sharer).unconfirmed }

  scope :of, ->(car) { where(car: car) }
  scope :for, ->(sharer) { where(sharer: sharer) }
  scope :current, -> { where("begins_at < ? AND ends_at > ?", Time.zone.now, Time.zone.now) }

  include AASM

  aasm column: :status do
    state :unconfirmed, initial: true
    state :confirmed

    event :confirm do
      transitions from: :unconfirmed, to: :confirmed
    end
  end

  def abandon!
    self.delete
  end

  def self.has_current_booking?(options)
    car = options[:car]
    sharer = options[:sharer]

    bookings = Booking.of(car).for(sharer).current

    if bookings.present?
      bookings.first
    else
      false
    end
  end
end

