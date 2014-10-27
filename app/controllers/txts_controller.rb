class TxtsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create

  def index
    @txts = Txt.all
  end

  def create
    ProcessIncomingTxtService.new(txt, gateway).process
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
end
