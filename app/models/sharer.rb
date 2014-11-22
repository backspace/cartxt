class Sharer < ActiveRecord::Base
  include AASM

  has_many :bookings

  enum role: [:user, :admin]

  scope :notify_of_bookings, -> { where(notify_of_bookings: true) }
  scope :receive_copies, -> {where(receive_copies: true) }

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

  def pending_balance
    balance - pending_payments
  end

  def pending_payments?
    pending_payments > 0
  end

  def user
    User.find_by(email: email)
  end

  def user?
    user.present?
  end
end
