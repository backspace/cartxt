module Responses
  class Bookings < DynamicResponse
    description "A list of bookings."

    expose :bookings, presenter: "BookingArray"

    # FIXME unless forloop.last only for tests
    default_body <<-TXT.strip_heredoc
      Your bookings:
      {% for booking in bookings %}{{ booking.formatted }}{% unless forloop.last %}
      {% endunless %}{% endfor %}
    TXT
  end
end
