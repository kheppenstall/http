require "minitest/autorun"
require "minitest/pride"
require './lib/date_time'

class DateTimeTest < Minitest::Test

  def test_it_exists
    assert DateTime.new
  end

  def test_it_outputs_date
    assert DateTime.new.output
  end
end