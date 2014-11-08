class Booking < ActiveRecord::Base
  belongs_to :car
  belongs_to :sharer

  scope :upcoming, -> { where("begins_at > ?", Time.now) }
  scope :overlapping, ->(start, finish) { where.not("ends_at < ? OR begins_at > ?", start, finish) }
  scope :unconfirmed_for, ->(car, sharer) { where(car: car, sharer: sharer).unconfirmed }

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
end

