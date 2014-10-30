class Booking < ActiveRecord::Base
  belongs_to :car
  belongs_to :sharer

  scope :upcoming, -> { where("begins_at > ?", Time.now) }
  scope :between, ->(start, finish) { where("(begins_at BETWEEN ? AND ?) OR (ends_at BETWEEN ? AND ?)", start, finish, start, finish) }
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

  def cancel!
    self.delete
  end
end

