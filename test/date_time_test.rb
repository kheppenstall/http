require "minitest/autorun"
require "minitest/pride"
require './lib/date_time'

class DateTimeTest < Minitest::Test

  def test_it_exists
    assert DateTime.output
  end

  def test_it_includes_year
    time = Time.now.strftime('%I:%M on %A, %B %d, %Y') 
    assert DateTime.output.include?(time)
  end
  
end

