class TxtsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create
  before_filter :validate_twilio_request, only: :create if Rails.env.production?

  def index
    @txts = Txt.all
  end

  def create
    begin
      ProcessIncomingTxtService.new(txt, gateway).process
    rescue StandardError => exception
      error_txt = Txt.new(from: params[:To], to: params[:From], body: "Sorry, there was an error! This is a work in progress.")

      gateway.deliver(from: error_txt.from, to: error_txt.to, body: error_txt.body) unless Rails.env.test?
      error_txt.save

      ExceptionNotifier.notify_exception(exception, env: request.env)

      throw exception if Rails.env.test?
    end

    render nothing: true
  end

  private
  def txt
    txt = Txt.new(from: params[:From], to: params[:To], body: params[:Body].strip)
    txt.save
    txt
  end

  def gateway
    if ENV['TWILIO_ACCOUNT_SID'].present?
      @gateway ||= TwilioGateway.new(Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']))
    elsif GatewayRepository.gateway.present?
      # FIXME figure out better dependency injection for testing?
      @gateway = GatewayRepository.gateway
    else
      @gateway ||= NullGateway.new
    end

    @gateway
  end

  # FIXME couples to Twilio
  def validate_twilio_request
    # https://github.com/twilio/twilio-ruby/wiki/RequestValidator
    validator = Twilio::Util::RequestValidator.new(ENV['TWILIO_AUTH_TOKEN'])
    url = "#{request.protocol}#{request.host_with_port}#{request.fullpath}"
    parameters = env['rack.request.form_hash']
    signature = env['HTTP_X_TWILIO_SIGNATURE']

    validator.validate url, parameters, signature
  end
end
