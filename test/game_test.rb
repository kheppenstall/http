require './lib/game'
require "minitest/autorun"
require "minitest/pride"

class GameTest < Minitest::Test

  def test_it_exists
    assert Game.new
  end

  def test_it_is_off_by_default
    game = Game.new
    refute game.condition
  end

  def test_start_turns_the_game_on
    game = Game.new
    game.start
    assert game.condition
  end

  def test_answer_is_between_0_and_100
    game = Game.new
    game.start
    assert game.answer >= 0 && game.answer <= 100
  end

  def test_guessing_too_high_reports_too_high
    game = Game.new
    game.start
    game.guess(101)
    expected = ["Your most recent guess of 101 was too high.", "You have made 1 guess."]
    assert_equal expected, game.status
  end

  def test_guessing_too_low_reports_too_low
    game = Game.new
    game.start
    game.guess(-1)
    expected = ["Your most recent guess of -1 was too low.", "You have made 1 guess."]
    assert_equal expected, game.status
  end

  def test_guessing_correctly_outputs_you_are_correct
    game = Game.new
    game.start
    game.guess(game.answer)
    expected = ["Your most recent guess of #{game.answer} was CORRECT!", "You have made 1 guess."]
    assert_equal expected, game.status
  end

  def test_only_guess_when_game_is_started
    game = Game.new
    game.guess(game.answer)
    expected = []
    assert_equal expected, game.status
  end

  def test_guessing_zero_times_outputs_0_guesses
    game = Game.new
    game.start
    expected = ["You have made 0 guesses."]
    assert_equal expected, game.status
  end

  def test_guessing_once_outputs_your_guess_and_number_of_guesses
    game = Game.new
    game.start
    game.guess(-1)
    expected = ["Your most recent guess of -1 was too low.", "You have made 1 guess."]
    assert_equal expected, game.status
  end

  def test_guessing_twice_outputs_your_guess_and_number_of_guesses
    game = Game.new
    game.start
    game.guess(-1)
    game.guess(-1)
    expected = ["Your most recent guess of -1 was too low.", "You have made 2 guesses."]
    assert_equal expected, game.status
  end

end
