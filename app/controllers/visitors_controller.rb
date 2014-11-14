class VisitorsController < ApplicationController
  before_filter :require_admin, if: :setup_required?
end
