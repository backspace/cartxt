class Borrowing < ActiveRecord::Base
  belongs_to :car
  belongs_to :sharer

  scope :of, ->(car) { where(car_id: car.id) }
  scope :incomplete, -> { where(final: nil) }
end
