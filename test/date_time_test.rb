require "minitest/autorun"
require "minitest/pride"
require './lib/date_time'

class DateTimeTest < Minitest::Test

  def test_it_exists
    assert DateTime.output
  end

  def test_it_includes_year
    assert DateTime.output.include?("2016")
  end
end