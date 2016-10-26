require './lib/hello_world'
require "minitest/autorun"
require "minitest/pride"

class HelloWorldTest < Minitest::Test

  def test_it_exists
    assert HelloWorld.new(0)
  end

  def test_it_outputs_total_requests_minus_1
    result = HelloWorld.new(0).output
    expected = "Hello, World! (0)"
    assert_equal expected, result
  end

end