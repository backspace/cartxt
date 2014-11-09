module ResponseHelper
  def render_response(response, parameters = {})
    response.new(parameters).body
  end
end
