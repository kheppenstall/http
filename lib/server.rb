require 'socket'

server = TCPServer.new(9292)
num = 0
loop do
  client = server.accept    
  client.puts "Hello !"
  client.puts "Time is #{Time.now}"
  num += 1
  string = "Hello, world (#{num})"
  client.puts string
  client.close
end