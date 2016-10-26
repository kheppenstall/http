require './lib/hello_world'
require "minitest/autorun"
require "minitest/pride"

class HelloWorldTest < Minitest::Test

  def test_it_exists
    assert HelloWorld.output(0)
  end
  
  def test_it_outputs_total_requests
    result = HelloWorld.output(1)
    expected = "Hello, World! (0)"
    assert_equal expected, result
  end

end