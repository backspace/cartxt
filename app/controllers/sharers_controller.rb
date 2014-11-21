class SharersController < ApplicationController
  before_filter :require_admin

  def index
    @sharers = Sharer.all
  end
end
