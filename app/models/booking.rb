class Booking < ActiveRecord::Base
  belongs_to :car
  belongs_to :sharer

  scope :upcoming, -> { where("begins_at > ?", Time.now) }
  scope :between, ->(start, finish) { where("(begins_at BETWEEN ? AND ?) OR (ends_at BETWEEN ? AND ?)", start, finish, start, finish) }
end
