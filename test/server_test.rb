require './lib/server'
require "minitest/autorun"
require "minitest/pride"
require 'faraday'

class ServerTest < Minitest::Test

  def test_it_exists
    assert Server.new
  end



  def test_hello_world_prints_with_1_request
    Server.new.hello_world
    response = Faraday.get 'http://127.0.0.1:9292/'
    assert_equal "Hello, World (0)", response
  end


end



