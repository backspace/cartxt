class TxtsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create

  def create
    ProcessIncomingTxtService.new(txt).process
    render nothing: true
  end

  private
  def txt
    OpenStruct.new(from: params[:From], to: params[:To], body: params[:Body])
  end
end
