require './lib/word_search'
require "minitest/autorun"
require "minitest/pride"

class WordSearchTest < Minitest::Test
  def test_it_exists
    assert WordSearch.new("hello")
  end

  def test_hello_is_a_known_word
    result = WordSearch.new("hello").output
    expected = "hello is a known word"
    assert_equal expected, result
  end

  def test_hel_is_not_a_known_word
    result = WordSearch.new("hel").output
    expected = "hel is not a known word"
    assert_equal expected, result
  end
  
  def test_nothing_is_not_a_known_word
    result = WordSearch.new("").output
    expected = " is not a known word"
    assert_equal expected, result
  end

  def test_HeLlo_is_a_known_word
    result = WordSearch.new("HeLlo").output
    expected = "HeLlo is a known word"
    assert_equal expected, result
  end
    

end
