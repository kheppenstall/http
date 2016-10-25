class Diagnostics

  attr_reader :request_lines

  def initialize(request_lines)
    @request_lines = request_lines
  end

  def populate
    diagnostics = []
    diagnostics << "<pre>"
    diagnostics << "Verb: #{verb}"
    diagnostics << "Path: #{path}"
    diagnostics << "Protocol: #{protocol}"
    diagnostics << "Host: #{host}"
    diagnostics << "Port: #{port}"
    diagnostics << "Accept: #{accept}"
    diagnostics << "Origin: #{host}"
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
    request_lines[6].split(':')[1].strip
  end

end