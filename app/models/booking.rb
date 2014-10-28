class Booking < ActiveRecord::Base
  belongs_to :car
  belongs_to :sharer

  scope :upcoming, -> { where("begins_at > ?", Time.now) }
end
