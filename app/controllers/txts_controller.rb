class TxtsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create

  def create
    GatewayRepository.gateway.deliver from: params[:To], to: params[:From], body: "Set odometer reading to #{params[:Body]}"
    render nothing: true
  end
end
