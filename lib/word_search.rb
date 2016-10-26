module WordSearch

  attr_reader :word

  # def initialize(word)
  #   @word = word
  # end

  def self.dictionary
    File.read('/usr/share/dict/words').split("\n")
  end

  def self.output(word)
    if known?(word) || known?(word.downcase)
      "#{word} is a known word"
    else
      "#{word} is not a known word"
    end
  end

  def self.known?(word)
    dictionary.include?(word)
  end

end