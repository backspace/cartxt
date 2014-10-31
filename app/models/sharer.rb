class Sharer < ActiveRecord::Base
  include AASM

  enum role: [:user, :admin]

  scope :notify_of_bookings, -> { where(notify_of_bookings: true) }

  def set_default_role
    self.role ||= :user
  end

  aasm column: :status do
    state :unknown, initial: true
    state :unnamed
    state :unapproved
    state :approved
    state :rejected

    event :know do
      transitions from: :unknown, to: :unnamed
    end

    event :bestow_name do
      transitions from: :unnamed, to: :unapproved
    end

    event :approve do
      transitions from: :unapproved, to: :approved
    end

    event :reject do
      transitions from: :unapproved, to: :rejected
    end
  end

  def rename!(new_name)
    self.bestow_name
    self.name = new_name
    save
  end
end
