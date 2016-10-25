class WordSearch

  attr_reader :word

  def initialize(word)
    @word = word
  end

  def dictionary
    File.read('/usr/share/dict/words').split("\n")
  end

  def output
    if known?
      "#{word} is a known word"
    else
      "#{word} is not a known word"
    end
  end

  def known?
    dictionary.include?(word)
  end

end