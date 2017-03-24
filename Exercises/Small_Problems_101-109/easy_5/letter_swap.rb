# letter_swap.rb

#Understand the problem
# Given a string of words separated by spaces, write a method that take this
# string of words and returns a string in which the first and last letters
# of every word is swapped.
# Assume every word contains at least one letter, and that the string will
# always contain at least one words. You may assume that each string contains
# nothing but words and spaces.
#  - Input: a string of words
#  - Output:
#  - Return: A string of words with first and last letter of each word switched
#
#Examples / Test Cases
#  swap('Oh what a wonderful day it is') == 'hO thaw a londerfuw yad ti si'
#  swap('Abcde') == 'ebcdA'
#  swap('a') == 'a'

#
#Data Structures
#  - Input: (string) words separated by spaces
#  - Intermediate: (words_arr) array of the words
#  - Output:
#  - Return: the answer
#
#Algorithm / Abstraction
#  - words = string.split(' ')
#  - words_swapped = words.map { switch the first and last letters}
#  - words_swapped.join(' ')


# Program
def swap(string)
  words = string.split(' ')
  words.map do |word|
    word[0], word[-1] = word[-1], word[0]
    word
  end.join(' ')
end

puts swap('Oh what a wonderful day it is') == 'hO thaw a londerfuw yad ti si'
puts swap('Abcde') == 'ebcdA'
puts swap('a') == 'a'

puts "-------------------"
puts "Further Exploration"
puts "-------------------"
# def swap_first_last_characters(a, b)
#   a, b = b, a
# end
# (disregard the lousy name) and called it like this:
#
# swap_first_last_characters(word[0], word[-1])

# This method would not work because we want to return the entire word back, not
# an array of the first and last letters switched.
