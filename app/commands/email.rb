module Commands
  class Email < AbstractCommand
    def initialize(options)
      super
      @address = options[:address]
      @context = options[:context]
    end

    def execute
      sharer.email = @address
      sharer.save

      host = @context[:host]
      site_url = Rails.application.routes.url_helpers.root_url(host: host)
      sign_up_url = Rails.application.routes.url_helpers.new_user_registration_url(host: host)

      @responses.push Responses::Email.new(car: car, sharer: sharer, site_url: site_url, sign_up_url: sign_up_url)
    end
  end
end
