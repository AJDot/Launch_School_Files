# reverse_it_part_1.rb

# Understand the problem
#   take a string and return and string with the words in reverse order
#   Input: string
#   Output: string with words in reverse order
#
# Examples / Test Cases
#   puts reverse_sentence('') == ''
#   puts reverse_sentence('Hello World') == 'World Hello'
#   puts reverse_sentence('Reverse these words') == 'words these Reverse'
#
# Data Structures
#   Input: string
#   array of words
#   Output: string
#
# Algorithm / Abstraction
#   input string.split into words
#   reverse the order of the array
#   array.join to make sentence again

# Program

def reverse_sentence(sentence)
  sentence.split.reverse.join(' ')
end

puts reverse_sentence('') == ''
puts reverse_sentence('Hello World') == 'World Hello'
puts reverse_sentence('Reverse these words') == 'words these Reverse'
