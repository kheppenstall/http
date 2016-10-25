require 'socket'

class Server

  attr_reader :server

  def initialize
    @server = TCPServer.new 9292
  end

  def hello_world
    counter = 0
    loop do
      request_lines = []
      client = server.accept 
      while line = client.gets and !line.chomp.empty?
        request_lines << line.chomp 
      end
      client.puts "Hello, world (#{counter})"
      counter += 1
      output_diagnostics(request_lines, client)
      client.close
    end
  end

  def output_diagnostics(request_lines, client)
    verb = request_lines[0].split(' ')[0]
    path = request_lines[0].split(' ')[1]
    protocol = request_lines[0].split(' ')[2]
    host = request_lines[1].split(':')[1].strip
    port = request_lines[1].split(':')[2]
    accept = request_lines[6].split(':')[1].strip
    client.puts "<pre>"
    client.puts "Verb: #{verb}"
    client.puts "Path: #{path}"
    client.puts "Protocol: #{protocol}"
    client.puts "Host: #{host}"
    client.puts "Port: #{port}"
    client.puts "Accept: #{accept}"
    client.puts "Origin: #{host}"
    client.puts "</pre>"
  end

end

Server.new.hello_world