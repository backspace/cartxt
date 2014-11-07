class ResponsesController < ApplicationController
  before_filter :require_admin

  def index
    @responses = dynamic_response_classes.reduce({}) do |hash, klass|
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

  def dynamic_response_classes
    Dir[Rails.root.join("app", "responses", "*.rb")].each {|file| require file}
    Responses::DynamicResponse.descendants.sort_by{|klass| klass.name}
  end
end
