# odd_words.rb

# Consider a character set consisting of letters, a space, and a point. Words consist of one or more, but at most 20 letters. An input text consists of one or more words separated from each other by one or more spaces and terminated by 0 or more spaces followed by a point. Input should be read from, and including, the first letter of the first word, up to and including the terminating point. The output text is to be produced such that successive words are separated by a single space with the last word being terminated by a single point. Odd words are copied in reverse order while even words are merely echoed. For example, the input string

# "whats the matter with kansas." becomes "whats eht matter htiw kansas."

# BONUS POINTS: the characters must be read and printed one at a time.

# Input:
#   - letters, space, point
#   - invalid characters: numbers, punctuations, underscores, anything but above
#   - no more than 20 letters per word.
#   - string will be one or more words separated by spaces, terminated by 0 or spaces and a point.
# Output:
#   - remove multiple spaces between words and at end
#   - odd words are copied in reverse order
#     - odd words are words with odd index
#   - even words are simply copied

# Test Cases:
# - one word
#   - "apply." # => "apply."
# - two words
#   - "apple butter." # => "apple rettub."
# - extra spaces
#   - "apple    butter    is  tasty   ." # => "apple rettub is ytsat."
# - more that 20 letters per word
#   - "thisisareallylongwordanditgoesonforever" # => produces input error
# - invalid characters
#   - "this string includes / which is invalid" # => produces input error

# Algorithm
# - input a string
# - test for invalid characters using regex
#   - throw error if invalid
# - test for words too long
#   - throw error if any_word.length > 20
# - split text into words
#  -
# - reverse word with odd index
# - join words with single space
# - add point at end

def odd_words(text)
  return "Invalid character in string!" if text =~ /[^a-zA-Z\. ]/
  text.gsub!('.', '')
  words = text.split(/ +/)
  return "Word length is too long!" if words.any? { |word| word.length > 20 }
  return "There aren't any words!" if words.length == 0

  result = words.each_with_index.map do |word, idx|
    idx.odd? ? word.reverse : word
  end

  result.join(' ') + '.'
end

p odd_words('whats the matter with kansas.')
p odd_words("this string includes / which is invalid.")
p odd_words("thisisareallylongwordanditgoesonforever even with other words.")
p odd_words("apple    butter    is  tasty   .")
p odd_words('.')
p odd_words('  .   ')