# reverse_it_part_2.rb

# Understand the problem
#   take a string and return and string with the words with 5 or more letters
#   reversed.
#   Input: string
#   Output: string with words that have 5 or more letters reverse order
#
# Examples / Test Cases
#   puts reverse_words('Professional')          # => lanoisseforP
#   puts reverse_words('Walk around the block') # => Walk dnuora the kcolb
#   puts reverse_words('Launch School')         # => hcnuaL loohcS
#
# Data Structures
#   Input: string
#   array of words
#   Output: string
#
# Algorithm / Abstraction
#   input string.split into words
#   reverse the order of word with 5 or more letters
#   array.join to make sentence again

# Program

def reverse_words(sentence)
  words = []
  sentence.split.each do |word|
    if word.size >= 5
      word.reverse!
    end
    words << word
  end
  words.join(' ')
end

puts reverse_words('Professional')          # => lanoisseforP
puts reverse_words('Walk around the block') # => Walk dnuora the kcolb
puts reverse_words('Launch School')         # => hcnuaL loohcS
