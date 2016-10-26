require 'socket'
require './lib/diagnostics'
require './lib/word_search'
require './lib/game'
require './lib/date_time'
require './lib/shutdown'
require './lib/hello_world'

class Server

  attr_reader :server,
              :game

  def initialize
    @server = TCPServer.new 9292
    form_response
  end

  def form_response
    requests = 0
    looping = true
    while looping do
      client = server.accept 
      request_lines = parse_request(client)
      request = Diagnostics.new(request_lines)
      response = []
      if request.verb == 'GET'
        case request.path
          when "/hello"
            response = [HelloWorld.new(requests).output, request.all]
          when "/datetime"
            response = [DateTime.new.output, request.all]
          when "/shutdown"
            response = [Shutdown.new(requests).output, request.all]
          when "/wordsearch"
            response = [WordSearch.new(request.value).output, request.all] if request.parameter == 'word'
          when "/game"
            response = [game.status, request.all] if game
          else
            response = [request.all]
        end
      elsif request.verb == 'POST'
        case request.path
          when "/start_game"
            response = ["Good luck!", request.all]
            @game = Game.new
          when "/game"
            game.guess(request.value) if request.parameter == 'guess' && game
            response = [request.all]
          else
            response = [request.all]
        end
      end
      requests += 1
      respond(response, client)
      client.close
      looping = false if request.path == "/shutdown"
    end
  end

  def respond(response, client)
    response = "<pre>" + response.join("\n") + "</pre>"
    output = "<html><head></head><body>#{response}</body></html>"
    headers = ["http/1.1 200 ok",
          "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
          "server: ruby",
          "content-type: text/html; charset=iso-8859-1",
          "content-length: #{output.length}\r\n\r\n"].join("\r\n")
    client.puts headers
    client.puts output
  end

  def parse_request(client)
    request_lines = []
    while line = client.gets and !line.chomp.empty?
      request_lines << line.chomp 
    end
    request_lines
  end
end