module Responses
  class Email < DynamicResponse
    description "Sent when a sharer sets their email address."

    expose :site_url
    expose :sign_up_url

    default_body "Recorded your email address as {{sender.email}}. {% if sender.user? %}You can now check your balance on the site: {{site_url}}{% else %}Visit {{sign_up_url}} and register that address.{% endif %}"
  end
end
