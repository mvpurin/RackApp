require_relative 'timeformat'
class App

  def call(env)
    request = Rack::Request.new(env)
    if valid_uri?(request)
      processing(request)
    else
      response(404, "Page not found \n")
    end
  end

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
        response['Content-Type'] = 'text/plain'
        response.write message
        response.finish
    end

  private

  def valid_uri?(request)
    request.fullpath[0..12] == '/time?format='
  end

end
