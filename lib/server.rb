require 'socket'
require './lib/diagnostics'

class Server

  attr_reader :server

  def initialize
    @server = TCPServer.new 9292
    respond
  end

  def respond
    counter = 0
    loop do
      request_lines = []
      client = server.accept 
      while line = client.gets and !line.chomp.empty?
        request_lines << line.chomp 
      end
      path = request_lines[0].split(' ')[1]
      case path
        when "/hello"
          client.puts hello_world(counter)
        when "/datetime"
          client.puts datetime
        when "/shutdown"
          client.puts shutdown(counter)
          client.puts diagnostics(request_lines)
          break
      end
      counter += 1
      client.puts diagnostics(request_lines)
      client.close
    end
  end

  def hello_world(counter)
    "Hello, world (#{counter})"
  end

  def datetime
    Time.now.strftime('%I:%M on %A, %B %d, %Y') 
  end

  def shutdown(counter)
    "Total Requests: #{counter + 1}"
  end

  def diagnostics(request_lines)
    Diagnostics.new(request_lines).populate
  end

end

Server.new