module Responses
  class Bookings < DynamicResponse
    description "A list of bookings."

    expose :bookings, presenter: "BookingArray"

    default_body <<-TXT.strip_heredoc
      {% if bookings == empty %}You have no upcoming bookings.{% else %}Your bookings:
      {% for booking in bookings %}\#{{ forloop.index}}: {{ booking.formatted }}
      {% endfor %}
      To abandon booking #1, send "abandon #1".{% endif %}
    TXT
  end
end
