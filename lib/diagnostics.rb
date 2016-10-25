class Diagnostics

  attr_reader :request_lines

  def initialize(request_lines)
    @request_lines = request_lines
  end

  def all
    diagnostics = []
    diagnostics << "<pre>"
    diagnostics << "Verb: #{verb}"
    diagnostics << "Path: #{path}"
    diagnostics << "Protocol: #{protocol}"
    diagnostics << "Host: #{host}"
    diagnostics << "Port: #{port}"
    diagnostics << "Accept: #{accept}"
    diagnostics << "Origin: #{origin}"
    diagnostics << "</pre>"
  end

  def verb
    request_lines[0].split(' ')[0]
  end

  def path
    path_and_parameters = request_lines[0].split(' ')[1]
    path_and_parameters.split('?')[0]
  end
  
  def protocol
    request_lines[0].split(' ')[2]
  end

  def host
    request_lines[1].split(':')[1].strip
  end

  def port
    request_lines[1].split(':')[2]
  end
  
  def accept
    accept_line = request_lines.find {|line| line.include?("Accept: ")}
    accept_line.split(': ')[1]
  end

  def origin
    origin_line = request_lines.find {|line| line.include?("Origin: ")}
    if origin_line
      origin_line.split(': ')[1]
    else
      host
    end
  end

  def parameters
    path_and_parameters = request_lines[0].split(' ')[1]
    params = path_and_parameters.split('?')[1]
    params = params.delete "\",/" if params
    params = params.split("=") if params
  end

  def parameter
    parameters[0] if parameters
  end

  def value
    parameters[1] if parameters
  end

end