# anagram.rb

class Anagram
  def initialize(word)
    @word = word
    @letters = letters @word
  end

  def match(test_words)
    test_words.sort.select do |test_word|
      next if test_word.downcase == @word.downcase  # => anagram can't be identical to @word
      anagram?(test_word)
    end
  end

  private

  def anagram?(test_word)
    letters(test_word) == @letters
  end

  def letters word
    word.downcase.chars.sort
  end
end

# Without #sort
class Anagram
  def initialize(word)
    @word = word
    @letters = letters @word
    @counts = letters_count @word
  end

  def match(test_words)
    test_words.select do |test_word|
      next if test_word.downcase == @word.downcase  # => anagram can't be identical to @word
      anagram?(test_word)
    end
  end

  private

  def anagram?(test_word)
    letters_count(test_word) == @counts
  end

  def letters_count word
    counts = Hash.new(0)
    word.downcase.each_char { |chr| counts[chr] += 1}
    counts
  end
end
