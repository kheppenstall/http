require 'socket'
require './lib/diagnostics'
require './lib/word_search'
require './lib/game'
require './lib/date_time'
require './lib/shutdown'
require './lib/hello_world'
require './lib/http_headers'

class Server

  attr_reader :server,
              :game

  def initialize
    @server = TCPServer.new 9292
    @game = Game.new
    enter_loop
  end

  def enter_loop
    requests = 0
    looping = true
    while looping do
      client = server.accept
      requests += 1
      request_lines = parse_request(client)
      request = Diagnostics.new(request_lines)
      response = form_response(request, requests)
      respond(response, client, request)
      client.close
      looping = false if request.path == "/shutdown"
    end
  end

  def parse_request(client)
    request_lines = []
    while line = client.gets and !line.chomp.empty?
      request_lines << line.chomp 
    end
    request_lines
  end
  
  def form_response(request, requests)
    if request.verb == 'GET'
      get_paths(request, requests) 
    elsif request.verb == 'POST'
      post_paths(request) 
    else
      []
    end
  end

  def get_paths(request, requests)
    case request.path
      when "/hello"
        [HelloWorld.output(requests), request.all]
      when "/datetime"
        [DateTime.output, request.all]
      when "/shutdown"
        [Shutdown.output(requests), request.all]
      when "/wordsearch"
        [WordSearch.output(request.value), request.all] if request.parameter == 'word'
      when "/game"
        [game.status, request.all]
      else
        [request.all]
    end
  end

  def post_paths(request)
    case request.path
      when "/start_game"
        game.start
        ["Good luck!", request.all]
      when "/game"
        game.guess(request.value) if request.parameter == 'guess'
        [request.all]
      else
        [request.all]
    end
  end

  def respond(response, client, request)
    response = "<pre>" + response.join("\n") + "</pre>"
    output = "<html><head></head><body>#{response}</body></html>"
    headers = HttpHeaders.make(output, request)
    client.puts headers
    client.puts output
  end

end