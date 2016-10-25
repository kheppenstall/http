require 'socket'
require './lib/diagnostics'
require './lib/word_search'
require './lib/game'


class Server

  attr_reader :server,
              :game

  def initialize
    @server = TCPServer.new 9292
    respond
  end

  def respond
    requests = 0
    loop do
      client = server.accept 
      request_lines = parse_request(client)
      request = Diagnostics.new(request_lines)
      
      if request.verb == 'GET'
        case request.path
          when "/hello"
            client.puts hello_world(requests)
          when "/datetime"
            client.puts datetime
          when "/shutdown"
            client.puts shutdown(requests)
            client.puts request.all
            break
          when "/wordsearch"
            client.puts WordSearch.new(request.value).output if request.parameter == 'word'
          when "/game"
            client.puts game.status if game
        end
      
      elsif request.verb == 'POST'
        case request.path
          when "/start_game"
            client.puts "Good luck!"
            @game = Game.new
          when "/game"
            game.guess(request.value) if request.parameter == 'guess' && game
        end
      end

      requests += 1
      client.puts request.all
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

  def hello_world(requests)
    "Hello, world (#{requests})"
  end

  def datetime
    Time.now.strftime('%I:%M on %A, %B %d, %Y') 
  end

  def shutdown(requests)
    "Total Requests: #{requests + 1}"
  end

end

Server.new