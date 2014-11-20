class Booking < ActiveRecord::Base
  has_paper_trail

  belongs_to :car
  belongs_to :sharer

  default_scope { order("begins_at") }
  scope :upcoming, -> { where("begins_at > ?", Time.now) }
  scope :overlapping, ->(start, finish) { where.not("ends_at < ? OR begins_at > ?", start, finish) }
  scope :unconfirmed_for, ->(car, sharer) { where(car: car, sharer: sharer).unconfirmed }

  scope :of, ->(car) { where(car: car) }
  scope :for, ->(sharer) { where(sharer: sharer) }

  # TODO parameterise?
  CURRENT_EARLINESS_WINDOW = 30.minutes

  scope :current, -> { where("begins_at <= ? AND ends_at >= ?", Time.zone.now + CURRENT_EARLINESS_WINDOW, Time.zone.now) }

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

  def begin!
    update_attributes begins_at: Time.zone.now
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

