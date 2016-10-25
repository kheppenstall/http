require './lib/diagnostics'
require "minitest/autorun"
require "minitest/pride"

  
class DiagnosticsTest < Minitest::Test

  attr_reader :get_request_lines,
              :post_request_lines

  def setup
    @get_request_lines = ["GET /wordsearch?word=world HTTP/1.1", 
                        "Host: 127.0.0.1:9292", 
                        "Connection: keep-alive", 
                        "Cache-Control: no-cache", 
                        "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.71 Safari/537.36", 
                        "Postman-Token: 45e20fea-03e1-389b-5696-4399e3cad251", 
                        "Accept: */*", 
                        "Accept-Encoding: gzip, deflate, sdch, br", 
                        "Accept-Language: en-US,en;q=0.8"]

    @post_request_lines = ["POST /wordsearch?word=world HTTP/1.1", 
                          "Host: 127.0.0.1:9292", 
                          "Connection: keep-alive", 
                          "Content-Length: 0", 
                          "Cache-Control: no-cache", 
                          "Origin: chrome-extension://fhbjgbiflinjbdggehcddcbncdddomop", 
                          "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.71 Safari/537.36", 
                          "Postman-Token: aefdd32d-8f8f-8c93-cb7a-456a3164b978", 
                          "Accept: */*", "Accept-Encoding: gzip, deflate, br",
                          "Accept-Language: en-US,en;q=0.8"]
  end

  def test_it_exists
    assert Diagnostics.new(get_request_lines)
  end

  def test_get_request_verb_is_get
    request = Diagnostics.new(get_request_lines)
    assert_equal "GET", request.verb
  end

  def test_get_request_path_is_wordsearch
    request = Diagnostics.new(get_request_lines)
    assert_equal "/wordsearch", request.path
  end

  def test_get_request_protocol_is_HTTP
    request = Diagnostics.new(get_request_lines)
    assert_equal "HTTP/1.1", request.protocol
  end

  def test_get_request_host_is_local_host
    request = Diagnostics.new(get_request_lines)
    assert_equal "127.0.0.1", request.host
  end

  def test_get_request_port_is_9292
    request = Diagnostics.new(get_request_lines)
    assert_equal "9292", request.port
  end

  def test_get_request_accept
    request = Diagnostics.new(get_request_lines)
    assert_equal "*/*", request.accept
  end

  def test_get_request_origin_is_self
    request = Diagnostics.new(get_request_lines)
    assert_equal "127.0.0.1", request.origin
  end

  def test_get_request_parameter_key_is_word
    request = Diagnostics.new(get_request_lines)
    assert_equal "word", request.parameter
  end

  def test_get_request_parameter_value_is_hello
    request = Diagnostics.new(get_request_lines)
    assert_equal "world", request.value
  end

  def test_post_request_verb_is_post
    request = Diagnostics.new(post_request_lines)
    assert_equal "POST", request.verb
  end

  def test_post_request_path_is_wordsearch
    request = Diagnostics.new(post_request_lines)
    assert_equal "/wordsearch", request.path
  end

  def test_post_request_protocol_is_HTTP
    request = Diagnostics.new(post_request_lines)
    assert_equal "HTTP/1.1", request.protocol
  end

  def test_post_request_host_is_local_host
    request = Diagnostics.new(post_request_lines)
    assert_equal "127.0.0.1", request.host
  end

  def test_post_request_port_is_9292
    request = Diagnostics.new(post_request_lines)
    assert_equal "9292", request.port
  end

  def test_post_request_accept
    request = Diagnostics.new(post_request_lines)
    assert_equal "*/*", request.accept
  end

  def test_post_request_origin_is_self
    request = Diagnostics.new(post_request_lines)
    expected = "chrome-extension://fhbjgbiflinjbdggehcddcbncdddomop"
    assert_equal expected, request.origin
  end

  def test_post_request_parameter_key_is_word
    request = Diagnostics.new(post_request_lines)
    assert_equal "word", request.parameter
  end

  def test_post_request_parameter_value_is_hello
    request = Diagnostics.new(post_request_lines)
    assert_equal "world", request.value
  end
  
end