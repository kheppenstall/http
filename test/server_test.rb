require "minitest/autorun"
require "minitest/pride"
require 'faraday'

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
    server = Faraday.get url
    assert_equal 200, server.status
  end

  def test_it_outputs_hello_world0_at_path_hello_world
    response = Faraday.get url + 'hello'
    assert response.body.include?("Hello, World!")
  end

  def test_hello_world_increments_with_each_request
    response1 = Faraday.get url + 'hello'
    response2 = response = Faraday.get url + 'hello'
    refute_equal response1.body, response2.body
  end

  def test_datetime_path_gives_date_and_time
    response = Faraday.get url + 'datetime'
    assert response.body.include?('2016')
  end

  def test_outputs_a_known_word_is_known
    response = Faraday.get url + 'wordsearch?word=world'
    assert response.body.include?("world is a known word")
  end

  def test_outputs_an_unkown_word_is_not_known
    response = Faraday.get url + 'wordsearch?word=wor'
    assert response.body.include?("wor is not a known word")
  end

  def test_outputs_an_uppercase_known_word_is_known
    response = Faraday.get url + 'wordsearch?word=WORLD'
    assert response.body.include?("WORLD is a known word")
  end

  def test_it_starts_the_game
    response = Faraday.post url + 'start_game'
    assert response.body.include?("Good luck!")
  end

  def test_it_only_starts_the_game_with_verb_post
    response = Faraday.get url + 'start_game'
    refute response.body.include?("Good luck!")
  end

  def test_it_counts_your_guesses
    Faraday.post url + 'game?guess=50'
    response = Faraday.get url + 'game'
    assert response.body.include?("You have made ")
  end

  def test_it_tells_you_when_you_guess_too_high
    Faraday.post url + 'game?guess=101'
    response = Faraday.get url + 'game'
    assert response.body.include?("too high.")
  end

  def test_it_tells_you_when_you_guess_too_low
    Faraday.post url + 'game?guess=-1'
    response = Faraday.get url + 'game'
    assert response.body.include?("too low.")
  end

  def test_the_game_redirects_after_a_guess
    response = Faraday.get url + 'game?guess=50'
    assert response.body.include?("GET")
  end

end



