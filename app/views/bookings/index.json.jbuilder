json.array! @bookings do |booking|
  json.start booking.begins_at
  json.end booking.ends_at
end
