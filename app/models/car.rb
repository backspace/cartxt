class Car < ActiveRecord::Base
  include AASM

  aasm column: :status do
    state :returned, initial: true
    state :borrowed

    event :borrow do
      transitions from: :returned, to: :borrowed
    end

    event :return do
      transitions from: :borrowed, to: :returned
    end
  end
end
