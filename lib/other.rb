require 'socket'
require 'faraday'
require 'net/http'
require 'uri'

# uri = URI.parse("http://127.0.0.1:9292/")
# response = Net::HTTP.get_response(uri)
# puts response.inspect


  # [@game.guess(guess_num), "HTTP 1.1 302 FOUND\nLocation: http://127.0.0.1:9292/game"]
server = Faraday.get url
    assert_equal 200, server.status

# url = "http://google.com"
# url = "http://127.0.0.1:9292/"

# conn = Faraday.new
# response = conn.get url
# p response.body

  # url = "http://127.0.0.1:9292/"
  # # url = 'http://google.com'
  #   conn = Faraday.new
  #   response = conn.get(url)
  #   puts response.body
  #   puts response.body.include?("Verb: GET").inspect

# conn = Faraday.new(:url => "google.com") do |faraday|
#   faraday.request  :url_encoded             # form-encode POST params
#   faraday.response :logger                  # log requests to STDOUT
#   faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
# end

# response =  conn.get

# server = TCPServer.new 9292 # Server bind to port 2000
# client = server.accept    # Wait for a client to connect
# request_lines = []
# while line = client.gets and !line.chomp.empty?
#   request_lines << line.chomp
# end


# client.puts request_lines.inspect
# verb = request_lines[0].split(' ')[0]
# path = request_lines[0].split(' ')[1]
# protocol = request_lines[0].split(' ')[2]
# host = request_lines[1].split(':')[1].strip
# port = request_lines[1].split(':')[2]
# accept = request_lines[6].split(':')[1].strip
# client.puts "<pre>"
# client.puts "Verb: #{verb}"
# client.puts "Path: #{path}"
# client.puts "Protocol: #{protocol}"
# client.puts "Host: #{host}"
# client.puts "Port: #{port}"
# client.puts "Accept: #{accept}"
# client.puts "Origin: #{host}"
# client.puts "</pre>"
# client.close
