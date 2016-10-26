require './lib/shutdown'
require "minitest/autorun"
require "minitest/pride"

class ShutdownTest < Minitest::Test

  def test_it_exists
    assert Shutdown.new(0)
  end

  def test_it_outputs_total_requests
    result = Shutdown.new(0).output
    expected = "Total Requests: 1"
    assert_equal expected, result
  end

end