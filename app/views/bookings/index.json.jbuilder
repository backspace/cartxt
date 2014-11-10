json.array! @bookings do |booking|
  json.start booking.begins_at
  json.end booking.ends_at
  if booking.sharer
    own_booking = booking.sharer == current_user.sharer
    json.title booking.sharer.name if own_booking || current_user.admin?
    json.className own_booking ? "own" : "other"
  end
end
