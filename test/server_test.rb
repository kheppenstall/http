require "minitest/autorun"
require "minitest/pride"
require 'faraday'
require './lib/server'

class ServerTest < Minitest::Test

  attr_reader :url

  def setup
    @url = 'http://127.0.0.1:9292/'
  end

  def test_host_is_local_host
    server = Faraday.new url
    assert_equal "127.0.0.1", server.host
  end

  def test_it_uses_the_correct_port
    server = Faraday.new url
    assert_equal 9292, server.port
  end

  def test_it_gives_200_as_status
    server = Faraday.new url
    response = server.get
  end



 

end



