module Responses
  class Who < DynamicResponse
    description "The list of sharers viewable by an admin."

    expose :sharers, presenter: 'SharerArray'

    # FIXME unless forloop.last only for tests
    default_body <<-TXT.strip_heredoc
    {% for sharer in sharers %}{{ sharer.formatted }}: {{ sharer.balance | as_currency }}{% if sharer.pending_payments? %} (pending {{sharer.pending_payments | as_currency}}){% endif %}{% unless forloop.last %}
    {% endunless %}{% endfor %}
    TXT
  end
end
