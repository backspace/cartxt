class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    if setup_required?
      setup_path(Wicked::FIRST_STEP)
    else
      root_path
    end
  end

  protected
  def require_admin
    authenticate_user!

    redirect_to root_path unless current_user.admin?
  end

  def setup_required?
    !Car.any? || !Sharer.any?
  end

  def gateway
    if ENV['TWILIO_ACCOUNT_SID'].present?
      @gateway ||= TwilioGateway.new(client)
    elsif GatewayRepository.gateway.present?
      # FIXME figure out better dependency injection for testing?
      @gateway = GatewayRepository.gateway
    else
      @gateway ||= NullGateway.new
    end

    @gateway
  end

  # FIXME find better placement
  def client
    Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']) if ENV["TWILIO_ACCOUNT_SID"].present?
  end
end
