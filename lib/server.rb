require 'socket'
require './lib/diagnostics'
require './lib/word_search'


class Server

  attr_reader :server

  def initialize
    @server = TCPServer.new 9292
    respond
  end

  def respond
    requests = 0
    loop do
      client = server.accept 
      request_lines = parse_request(client)
      
      case path(request_lines)
        when "/hello"
          client.puts hello_world(requests)
        when "/datetime"
          client.puts datetime
        when "/shutdown"
          client.puts shutdown(requests)
          client.puts diagnostics(request_lines)
          break
        when "/wordsearch"
          client.puts word_search(request_lines)
      end

      requests += 1
      client.puts diagnostics(request_lines)
      client.close
    end
  end

  def parse_request(client)
    request_lines = []
    while line = client.gets and !line.chomp.empty?
      request_lines << line.chomp 
    end
    request_lines
  end
  
  def path(request_lines)
    path_and_parameters = request_lines[0].split(' ')[1]
    path_and_parameters.split('?')[0]
  end

  def parameters(request_lines)
    path_and_parameters = request_lines[0].split(' ')[1]
    params = path_and_parameters.split('?')[1]
    params = params.delete "\",/" if params
    params = params.split("=") if params
  end

  def parameter(request_lines)
    parameters(request_lines)[0] if parameters(request_lines)
  end

  def value(request_lines)
    parameters(request_lines)[1] if parameters(request_lines)
  end

  def hello_world(requests)
    "Hello, world (#{requests})"
  end

  def datetime
    Time.now.strftime('%I:%M on %A, %B %d, %Y') 
  end

  def shutdown(requests)
    "Total Requests: #{requests + 1}"
  end

  def diagnostics(request_lines)
    Diagnostics.new(request_lines).populate
  end

  def word_search(request_lines)
    value = value(request_lines)
    parameter = parameter(request_lines)
    WordSearch.new(value).output if parameter == 'word'
  end

end

Server.new