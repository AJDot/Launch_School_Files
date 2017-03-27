# the_end_is_near_but_not_here.rb

#Understand the problem
#  Write a method that returns the next to last word in the String passed to it
#  as an argument.
#  Words are any sequence of non-blank characters.
#  You may assume that the input String will always contain at least two words.
#  - Input: string of words
#  - Output:
#  - Return: second to last word
#
#Examples / Test Cases
#  penultimate('last word') == 'last'
#  penultimate('Launch School is great!') == 'is'

#Data Structures
#  - Input: (string) = words
#  - Intermediate:
#  - Output:
#  - Return: second to last word
#
#Algorithm / Abstraction
#  - string.split[-2]

# Program
puts "\n-------"
puts "Program"
puts "-------"
def penultimate(string)
  string.split[-2]
end

puts penultimate('last word') == 'last'
puts penultimate('Launch School is great!') == 'is'

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"
# Suppose we need a method that retrieves the middle word of a phrase/sentence.
# What edge cases need to be considered? How would you handle those edge
# cases without ignoring them? Write a method that returns the middle word of
# a phrase or sentence. It should handle all of the edge cases you thought of.

# Edge Cases
# When there are 0, 1, or any even number, of words
def middle_word(string)
  words = string.split
  word_count = words.length
  mid_index = word_count / 2
  if word_count == 0
    ''
  elsif word_count.even?
    # if even number of words, return the two words across the middle.
    "#{words[mid_index - 1]} #{words[mid_index]}"
  else
    words[mid_index]
  end
end

puts middle_word('this is the last word') == 'the'
puts middle_word('this is the last word isn\'t it?') == 'last'
puts middle_word('this is the last') == 'is the'
puts middle_word('') == ''
puts middle_word('this') == 'this'
