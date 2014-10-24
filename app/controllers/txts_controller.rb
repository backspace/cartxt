class TxtsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create

  def index
    @txts = Txt.all
  end

  def create
    ProcessIncomingTxtService.new(txt).process
    render nothing: true
  end

  private
  def txt
    txt = Txt.new(from: params[:From], to: params[:To], body: params[:Body].strip)
    txt.save
    txt
  end
end
