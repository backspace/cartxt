module Responses
  class Bookings < DynamicResponse
    description "A list of bookings."

    expose :bookings, presenter: "BookingArray"

    # FIXME unless forloop.last only for tests
    default_body <<-TXT.strip_heredoc
      {% if bookings == empty %}You have no upcoming bookings.{% else %}Your bookings:
      {% for booking in bookings %}{{ booking.formatted }}{% unless forloop.last %}
      {% endunless %}{% endfor %}{% endif %}
    TXT
  end
end
