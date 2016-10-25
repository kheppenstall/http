require 'socket'

server = TCPServer.new 9292 # Server bind to port 2000
client = server.accept    # Wait for a client to connect
request_lines = []
while line = client.gets and !line.chomp.empty?
  request_lines << line.chomp
end


client.puts request_lines
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
client.close
