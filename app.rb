require_relative 'timeformat'
class App

  def call(env)
    request = Rack::Request.new(env)
    processing(request)
  end

  private

  def processing(request)
    time = TimeFormat.new(request.params['format'].split(","))
    if time.valid?
      response(200, time.result)
    else
      response(400, "Unknown time format #{ time.invalid_params } \n")
    end
  end

  def response(answer_code, message)
    response = Rack::Response.new
    response.status = answer_code
    response.write message
    response.finish
  end

end
