class ResponsesController < ApplicationController
  before_filter :require_admin

  def index
    @responses = [Responses::ReturnFailure].reduce({}) do |hash, klass|
      hash[klass] = klass.find_or_build_response
      hash
    end
  end

  def create
    @response = Response.new(response_params)

    if @response.save
      redirect_to responses_path
    end
  end

  def update
    @response = Response.find(params[:id])
    @response.update!(response_params)
    redirect_to responses_path
  end

  private
  def response_params
    params.require(:response).permit(:name, :body)
  end
end
