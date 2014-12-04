class SharersController < ApplicationController
  before_filter :require_admin

  def index
    @sharers = Sharer.all
  end

  def update
    @sharer = Sharer.find(params[:id])
    @sharer.update!(sharer_params)
    redirect_to sharers_path
  end

  private
  def sharer_params
    params.require(:sharer).permit(:admin, :receive_copies)
  end
end
