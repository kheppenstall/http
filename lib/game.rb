class Game

  attr_reader :answer,
              :guesses,
              :recent_guess,
              :condition

  def initialize
    @answer = rand(100)
    @guesses = 0
    @recent_guess = nil
    @condition = false
  end

  def start
    @condition = true
  end

  def guess(number)
    if condition
      @guesses += 1
      @recent_guess = number.to_i
      result_of_guess
    end
  end

  def result_of_guess
    if recent_guess == answer
      "CORRECT!"
    elsif recent_guess < answer
      "too low."
    elsif recent_guess > answer
      "too high."
    end
  end

  def status
    response = []
    if condition
      response << "Your most recent guess of #{recent_guess} was #{result_of_guess}" unless guesses == 0
      if guesses == 1
        response << "You have made #{guesses} guess." 
      else
        response << "You have made #{guesses} guesses."
      end
    end
    response
  end
end